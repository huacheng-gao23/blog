require "test_helper"

class Blog::ReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_reviews_index_url
    assert_response :success
  end

  test "should get show" do
    get blog_reviews_show_url
    assert_response :success
  end
end
