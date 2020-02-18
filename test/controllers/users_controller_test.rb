require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get users_welcome_url
    assert_response :success
  end

end
