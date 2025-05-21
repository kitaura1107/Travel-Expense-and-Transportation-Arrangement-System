require "test_helper"

class XxUserIds::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get fetch_username" do
    get xx_user_ids_users_fetch_username_url
    assert_response :success
  end
end
