ENV['RACK_ENV'] = 'test'

require 'webmock/minitest'
WebMock.disable_net_connect!(allow: %w{codeclimate.com})

require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
SimpleCov.start do
  add_filter '/vendor/'
end

require 'minitest/autorun'
require 'rack/test'

require_relative '../app.rb'
