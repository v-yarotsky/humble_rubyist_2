module HumbleRubyist

  class Config
    attr_accessor :posts_path

    def initialize
      @posts_path = "posts"
    end
  end

end

