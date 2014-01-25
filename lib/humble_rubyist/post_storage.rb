require "ostruct"
require "date"
require "humble_rubyist/post"

module HumbleRubyist

  class PostStorage
    def initialize(posts_path)
      @path = posts_path
    end

    def posts
      Dir.glob(File.join(@path, "published", "*.md")).each_with_object([]) do |post_filename, posts|
        post_date, post_slug = File.basename(post_filename, ".md").match(/\A(\d{8})-([\w-]+)\Z/).captures
        post_date = Date.parse(post_date)
        posts << HumbleRubyist::Post.new(post_date, post_slug, File.read(post_filename))
      end
    end
  end

end

