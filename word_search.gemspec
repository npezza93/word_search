# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "word_search/version"

Gem::Specification.new do |spec|
  spec.name                  = "word_search"
  spec.version               = WordSearch::VERSION
  spec.required_ruby_version = ">= 2.4"
  spec.authors               = ["npezza93"]
  spec.email                 = ["npezza93@gmail.com"]

  spec.summary               = "Word Search Generator and Solver"
  spec.description           = "Makes word searches and solves them"
  spec.homepage              = "https://www.github.com/npezza93/word_searcher"
  spec.license               = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", "~> 5.1"
  spec.add_dependency "activesupport", "~> 5.1"
  spec.add_dependency "ruby-enum", "~> 0.6.0"

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 12.0"
end
