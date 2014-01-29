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
      template = template_storage.retrieve_template("posts")
      posts = post_storage.posts
      rendered_template = HumbleRubyist::View.new(template, posts: posts).render
      [200, { "Content-Type" => "text/html" }, [rendered_template]]
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

