require "unit/test_helper"
require "humble_rubyist/template_storage"

module HumbleRubyist

  class TestTemplateStorage < HRTest
    def setup
      @template_storage = HumbleRubyist::TemplateStorage.new("test/fixtures/templates")
    end

    test "retrieve template" do
      template = @template_storage.retrieve_template("demo")
      assert_equal "Demo Template Contents\n", template
    end
  end

end

