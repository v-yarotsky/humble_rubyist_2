module HumbleRubyist

  class Config
    attr_accessor :posts_path, :templates_path

    def initialize
      @posts_path = "posts"
      @templates_path = "templates"
    end
  end

end

