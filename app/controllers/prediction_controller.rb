class PredictionController < ApplicationController
  def get_iex_data_for_predict api_call
    iex_token = Rails.application.credentials.iex[:publishable]
    url = URI.parse("https://cloud.iexapis.com/stable/stock/" + api_call + "/chart/6m?filter=date,close&chartCloseOnly=true&token=" + iex_token.to_s)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    req = Net::HTTP::Get.new url.request_uri
    resp = http.request(req)
    resp.body
  end
  def get_prediction data
    sm_client = Aws::SageMakerRuntime::Client.new( credentials:  Aws::Credentials.new(Rails.application.credentials[:aws][:access_key_id], Rails.application.credentials[:aws][:secret_access_key]), region: "us-east-1" )
    sm_client.invoke_endpoint( { endpoint_name: 'stochast-predictions', body: data } )
  end
  def show
    @iexdata = get_iex_data_for_predict params[:symbol]
    iexjson = JSON.parse( @iexdata ).select { |q| q['date'] }
    @iex_chart_data = iexjson.map { |q| [q['date'], q['close']] }
    pred_start = @iex_chart_data[0][0]
    pred_target = @iex_chart_data.map { |q| q[1] }
    pred_req_data = JSON.generate( { 'instances' => [ {'start' => pred_start, 'target' => pred_target } ], 'configuration' => { 'num_samples' => 1000, 'output_types' => ['quantiles'], 'quantiles' => ['0.1', '0.5', '0.9'] } } )
    @pred = JSON.parse( get_prediction( pred_req_data ).body.string )
    next_date = DateTime.parse(@iex_chart_data[-1][0]).next_day
    @next_dates = []
    5.times do |i|
      @next_dates.append(next_date.strftime("%m/%d/%y"))
      next_date = next_date.next_day
    end
    @pred_chart_data = @pred['predictions'][0]['quantiles'].map do |k, v|
      new_series = {}
      new_series['name'] = k
      new_series['data'] = @next_dates.zip(v)
      new_series
    end
    @pred_chart_data.each { |s| s['data'].unshift @iex_chart_data[-1] }
    old_series = { name: params[:symbol], data: @iex_chart_data.last(15) }
    @pred_chart_data.unshift(old_series)
  end
end
