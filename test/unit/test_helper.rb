require "bundler/setup"
require "minitest/autorun"
require "minitest/pride"

$:.unshift File.expand_path("../../../lib", __FILE__)

class HRTest < Minitest::Test
end

