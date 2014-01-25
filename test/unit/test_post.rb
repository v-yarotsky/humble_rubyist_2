require "unit/test_helper"
require "humble_rubyist/post"
require "date"

module HumbleRubyist

  class TestPost < HRTest
    def setup
      @post = HumbleRubyist::Post.new(Date.parse("20140127"), "test-post", <<POST)
# Category: ruby
# Tags: anything, anywhere

Ohai.
  Doing things here
====

The post begins here

<!-- more -->

The post continues here

The example post could look like:

```
# Category: faux
# Tags: foo, bar

The Title
=========

Teaser

<!-- more -->

Rest of the post
```

POST
    end

    def test_has_date
      assert_equal Date.parse("20140127"), @post.date
    end

    def test_has_slug
      assert_equal "test-post", @post.slug
    end

    def test_has_category
      assert_equal "ruby", @post.category
    end

    def test_does_not_parse_metadata_mid_post
      refute_equal "faux", @post.category
    end

    def test_has_tags
      assert_equal ["anything", "anywhere"], @post.tags
    end

    def test_has_title
      assert_equal "Ohai.\n  Doing things here", @post.title
    end

    def test_has_teaser
      assert_equal "The post begins here", @post.teaser
    end

    def test_has_content
      assert_equal <<POST.strip, @post.content
The post continues here

The example post could look like:

```
# Category: faux
# Tags: foo, bar

The Title
=========

Teaser

<!-- more -->

Rest of the post
```
POST
    end
  end

  def test_renders_nice_html
    skip "Parse output with nokogiri and check it"
  end

end

