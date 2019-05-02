require 'test_helper'

class TickerSymbolControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ticker_symbol_index_url
    assert_response :success
  end

  test "should get show" do
    get ticker_symbol_show_url
    assert_response :success
  end

end
