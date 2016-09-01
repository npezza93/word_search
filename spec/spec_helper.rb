require 'codeclimate-test-reporter'
require 'simplecov'
CodeClimate::TestReporter.start
SimpleCov.start

require 'bundler/setup'
require 'word_search'
require 'pry'

Bundler.setup
RSpec.configure do |config|
end
