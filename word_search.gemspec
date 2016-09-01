# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'word_search/version'

Gem::Specification.new do |spec|
  spec.name          = 'word_search'
  spec.version       = WordSearch::VERSION
  spec.authors       = ['npezza93']
  spec.email         = ['npezza93@gmail.com']

  spec.summary       = 'Word Search Generator and Solver'
  spec.description   = 'Makes word searches and solves them'
  spec.homepage      = 'https://www.github.com/npezza93/word_searcher'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '< 5.1'
  spec.add_dependency 'activemodel', '< 5.1'
  spec.add_dependency 'ruby-enum', '~> 0.5.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'rubocop', '~> 0.42.0'
  spec.add_development_dependency 'codeclimate-test-reporter'
end
