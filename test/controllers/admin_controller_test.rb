require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get terms of service" do
    get "/tos"
    assert_response :success
  end
  test "should get pricavy policy page" do
    get "/privacy-policy"
    assert_response :success
  end
  test "should log out" do
    get "/logout"
    assert( flash["alert-danger"], "You have logged out.")
    assert_redirected_to("/")
  end
  test 'should get root from nonsense' do
    get '/wp-admin/login.php'
    assert_redirected_to("/")
  end
  test 'should redirect non-logged-in user' do
    get "/dashboard"
    assert( flash["alert-danger"], "Nope." )
    assert_redirected_to("/")
  end
end
