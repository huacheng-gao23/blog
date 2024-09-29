require "test_helper"

class Blog::NewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get blog_news_index_url
    assert_response :success
  end

  test "should get show" do
    get blog_news_show_url
    assert_response :success
  end
end
