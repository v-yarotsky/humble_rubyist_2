require "unit/test_helper"
require "humble_rubyist/view"

module HumbleRubyist

  class TestView < HRTest
    TEST_TEMPLATE = <<-TPL.strip
Hi there, the_value is:
<%= @the_value %>
        TPL

    def test_renders_erb
      template = HumbleRubyist::View.new(TEST_TEMPLATE, the_value: 42)
      assert_equal <<-RENDERED_TPL.strip, template.render
Hi there, the_value is:
42
      RENDERED_TPL
    end

  end

end


