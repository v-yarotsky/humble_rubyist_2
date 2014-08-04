require "unit/test_helper"
require "humble_rubyist/application"

module HumbleRubyist

  class TestApplication < HRTest
    def setup
      @app = HumbleRubyist::Application.instance
    end

    test "has config" do
      cfg = @app.config
      refute_nil cfg
    end

    test "configure yields config" do
      cfg = @app.config
      yielded_cfg = nil
      @app.configure do |config|
        yielded_cfg = config
      end
      assert_same cfg, yielded_cfg
    end

    test "renders posts" do
      skip
    end
  end

end

