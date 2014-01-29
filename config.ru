$:.unshift File.expand_path("../lib", __FILE__)

require 'webrick'

WEBrick::Config::General[:DoNotReverseLookup] = true

require "humble_rubyist/application"

use Rack::Static, :urls => ["/css"], :root => "public"
run HumbleRubyist::Application.instance

