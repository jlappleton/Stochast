require 'test_helper'

class PredictionControllerTest < ActionDispatch::IntegrationTest
  test "should get prediction partial" do
    get "/prediction/AAPL/01", params: { symbol: 'AAPL' }, xhr: true
    assert_response :success
  end
  test "should get admin prediction partial" do
    post "/prediction/admin", params: { symb: { name: 'AAPL' } }, xhr: true
    assert_response :success
  end
end
