require "humble_rubyist/config"
require "humble_rubyist/post_storage"
require "humble_rubyist/template_storage"
require "humble_rubyist/view"

module HumbleRubyist

  class Application
    include Singleton

    attr_reader :config

    def initialize
      @config = HumbleRubyist::Config.new
    end

    def configure
      yield @config
    end

    def call(env)
      case [env["PATH_INFO"], env["REMOTE_ADDR"]]
      when ["/styleguide", "127.0.0.1"]
        require "kss"
        require "humble_rubyist/styleguide"
        styleguide_template = template_storage.retrieve_template("styleguide")
        styleguide_example_template = template_storage.retrieve_template("_styleguide_example")
        styleguide = Kss::Parser.new("public/css/style.css")
        rendered_template = HumbleRubyist::Styleguide.new(styleguide_template,
                                                          styleguide_example_template,
                                                          styleguide).render

        [200, { "Content-Type" => "text/html" }, [rendered_template]]
      else
        template = template_storage.retrieve_template("posts")
        posts = post_storage.posts
        rendered_template = HumbleRubyist::View.new(template, posts: posts).render
        [200, { "Content-Type" => "text/html" }, [rendered_template]]
      end
    end

    private

    def template_storage
      @template_storage ||= HumbleRubyist::TemplateStorage.new(config.templates_path)
    end

    def post_storage
      @post_storage ||= HumbleRubyist::PostStorage.new(config.posts_path)
    end
  end

end

