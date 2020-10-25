require 'test_helper'

class ChartsControllerTest < ActionDispatch::IntegrationTest
  test "should get weekly" do
    get charts_weekly_url
    assert_response :success
  end
end
