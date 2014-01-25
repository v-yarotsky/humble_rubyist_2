require "humble_rubyist/config"
require "humble_rubyist/post_storage"

module HumbleRubyist

  class Application
    @config = HumbleRubyist::Config.new

    class << self
      attr_reader :config

      def call(env)
        post_storage = HumbleRubyist::PostStorage.new(config.posts_path)
        [200, { "Content-Type" => "text/html" }, post_storage.posts.map(&:render)]
      end

      def configure
        yield @config
      end
    end
  end

end

