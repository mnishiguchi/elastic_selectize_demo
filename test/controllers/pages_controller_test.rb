require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get github_search" do
    get pages_github_search_url
    assert_response :success
  end

end
