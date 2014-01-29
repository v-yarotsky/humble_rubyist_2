require "unit/test_helper"
require "humble_rubyist/application"

module HumbleRubyist

  class TestApplication < HRTest
    def setup
      @app = HumbleRubyist::Application.instance
    end

    def test_has_config
      cfg = @app.config
      refute_nil cfg
    end

    def test_configure_yields_config
      cfg = @app.config
      yielded_cfg = nil
      @app.configure do |config|
        yielded_cfg = config
      end
      assert_same cfg, yielded_cfg
    end

    def test_renders_posts
      skip
    end
  end

end

