require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers

  test "should get home page" do
    get :index
    assert_response(200)
  end
end
