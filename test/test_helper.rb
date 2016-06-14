ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require 'webmock/minitest'

require_relative '../app.rb'
