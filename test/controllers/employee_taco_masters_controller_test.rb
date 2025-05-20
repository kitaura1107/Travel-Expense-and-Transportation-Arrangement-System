require "test_helper"

class EmployeeTacoMastersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get employee_taco_masters_new_url
    assert_response :success
  end

  test "should get index" do
    get employee_taco_masters_index_url
    assert_response :success
  end
end
