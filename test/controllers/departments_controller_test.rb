require "test_helper"

class DepartmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get departments_new_url
    assert_response :success
  end

  test "should get index" do
    get departments_index_url
    assert_response :success
  end
end
