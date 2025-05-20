require "test_helper"

class TravelRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get travel_requests_new_url
    assert_response :success
  end

  test "should get index" do
    get travel_requests_index_url
    assert_response :success
  end
end
