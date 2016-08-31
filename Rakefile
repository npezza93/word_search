require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

task :console do
  require 'pry'
  require 'word_searcher'
  ARGV.clear
  Pry.start
end

RuboCop::RakeTask.new
RSpec::Core::RakeTask.new(:spec)
task default: [:spec, :rubocop]
