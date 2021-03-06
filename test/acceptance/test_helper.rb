require "bundler/setup"
require "minitest/autorun"
require "capybara"
require "humble_rubyist/application"

class HRAcceptanceTest < Minitest::Test
  include Capybara::DSL

  def setup
    HumbleRubyist::Application.instance.configure do |app|
      app.posts_path = "test/fixtures/posts"
    end
    Capybara.app = HumbleRubyist::Application.instance
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

