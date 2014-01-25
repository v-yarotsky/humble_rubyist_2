require "redcarpet"
require "pygments"

module HumbleRubyist

  class Post
    class PygmentizedRenderer < Redcarpet::Render::HTML
      def block_code(code, language = :ruby)
        Pygments.highlight(code, lexer: language, options: { linenos: "table" })
      end
    end

    attr_reader :date, :slug, :category, :tags, :title, :content, :teaser

    def initialize(date, slug, raw_content)
      @date = date
      @slug = slug
      parse_raw_content(raw_content)
    end

    private

    def parse_raw_content(raw_content)
      raw_content_lines = raw_content.split("\n")
      is_metainfo = proc { |s| s.start_with?("#") }
      raw_metainfo = raw_content_lines.take_while(&is_metainfo)
      raw_post = raw_content_lines.drop_while(&is_metainfo).drop_while(&:empty?)
      parse_raw_metainfo(raw_metainfo.join("\n"))
      parse_raw_post(raw_post.join("\n"))
    end

    def parse_raw_metainfo(raw_metainfo)
      raw_metainfo.each_line do |line|
        field, value = line.match(/\A#\s*(\w+):\s*(.*)\Z/).captures
        case field.downcase
        when "category"
          @category = value
        when "tags"
          @tags = value.split(/,\s*/)
        end
      end
    end

    def parse_raw_post(raw_post)
      @title, rest = raw_post.split(/^=+$/, 2).map(&:strip)
      @teaser, @content = rest.split(/^<!-- more -->$/, 2).map(&:strip)
    end

    public

    # TODO: test
    def render
      renderer = Redcarpet::Markdown.new(PygmentizedRenderer.new,
                                         no_intra_emphasis: true,
                                         fenced_code_blocks: true,
                                         autolink: true,
                                         tables: true,
                                         with_toc_data: true,
                                         no_styles: true)
      renderer.render("#%s\n\n%s\n\n%s" % [@title, @teaser, @content])
    end
  end

end

