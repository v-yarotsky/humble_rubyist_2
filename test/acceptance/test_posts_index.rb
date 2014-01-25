require "acceptance/test_helper"

class TestPostsIndex < HRAcceptanceTest
  def test_renders_published_posts
    visit "/"
    assert_includes page.body, "How I stopped worrying and embraced Minitest"
  end
end

