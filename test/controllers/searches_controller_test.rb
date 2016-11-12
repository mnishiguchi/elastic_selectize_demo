require 'test_helper'

class SearchesControllerTest < ActionDispatch::IntegrationTest
  test "should get weather" do
    get searches_weather_url
    assert_response :success
  end

end
