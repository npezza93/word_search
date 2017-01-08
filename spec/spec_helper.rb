# frozen_string_literal: true
require "simplecov"
SimpleCov.start

require "bundler/setup"
require "word_search"
require "pry"

Bundler.setup
RSpec.configure do |config|
  config.mock_with :mocha
end
