require "unit/test_helper"
require "humble_rubyist/view"

module HumbleRubyist

  class TestView < HRTest
    TEST_TEMPLATE = <<TPL.strip
Hi there, the_value is:
<%= @the_value %>
TPL

    test "renders erb" do
      template = HumbleRubyist::View.new(TEST_TEMPLATE, the_value: 42)
      assert_equal "Hi there, the_value is:\n42", template.render
    end

    test "can live without template values" do
      template = HumbleRubyist::View.new(TEST_TEMPLATE)
      assert_equal "Hi there, the_value is:\n", template.render
    end
  end

end


