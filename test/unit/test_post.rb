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

    test "has date" do
      assert_equal Date.parse("20140127"), @post.date
    end

    test "has slug" do
      assert_equal "test-post", @post.slug
    end

    test "has category" do
      assert_equal "ruby", @post.category
    end

    test "does not parse metadata mid post" do
      refute_equal "faux", @post.category
    end

    test "has tags" do
      assert_equal ["anything", "anywhere"], @post.tags
    end

    test "has title" do
      assert_equal "Ohai.\n  Doing things here", @post.title
    end

    test "has teaser" do
      assert_equal "The post begins here", @post.teaser
    end

    test "has content" do
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

    test "renders nice html" do
      skip "Parse output with nokogiri and check it"
    end
  end

end

