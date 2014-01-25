require "unit/test_helper"
require "humble_rubyist/post_storage"
require "date"

module HumbleRubyist

  class TestPostStorage < HRTest
    def setup
      @post_storage = HumbleRubyist::PostStorage.new("test/fixtures/posts")
    end

    def test_loads_posts
      expected_post_attributes = { date: Date.parse("20140127"), slug: "test-post", title: "How I stopped worrying and embraced Minitest" }
      assert_equal [expected_post_attributes.values_at(:date, :slug, :title)], @post_storage.posts.map { |p| [p.date, p.slug, p.title] }
    end

  end

end

