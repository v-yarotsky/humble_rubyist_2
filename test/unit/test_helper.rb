require "bundler/setup"
require "minitest/autorun"

$:.unshift File.expand_path("../../../lib", __FILE__)

class HRTest < Minitest::Test
  def self.test(name, &block)
    block ||= proc { skip }
    define_method("test_#{name}", &block)
  end

  def self.xtest(name, &block)
    test(name)
  end
end

