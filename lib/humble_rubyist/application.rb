require "humble_rubyist/config"
require "humble_rubyist/post_storage"

module HumbleRubyist

  class Application
    @config = HumbleRubyist::Config.new

    class << self
      attr_reader :config

      def call(env)
        post_storage = HumbleRubyist::PostStorage.new(config.posts_path)
        [200, { "Content-Type" => "text/html" }, [<<HTML]]
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <link href="/css/syntax.css" rel="stylesheet">
  </head>
  <body>
    #{post_storage.posts.map(&:render).join("\n")}
  </body>
</html>
HTML
      end

      def configure
        yield @config
      end
    end
  end

end

