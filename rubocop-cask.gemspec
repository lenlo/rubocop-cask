$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require 'rubocop/cask/version'

Gem::Specification.new do |s|
  s.name = 'rubocop-cask'
  s.summary = 'Code style checking for Homebrew-Cask files'
  s.description = <<-DESCRIPTION
    Code style checking for Homebrew-Cask files.
    A plugin for the RuboCop code style enforcing & linting tool.
  DESCRIPTION
  s.homepage = 'https://github.com/caskroom/rubocop-cask'
  s.authors = ['Joshua Hagins']
  s.email = ['hagins.josh@gmail.com']
  s.license = 'MIT'

  s.version = RuboCop::Cask::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1'

  s.require_paths = ['lib']
  s.files = Dir[
    'config/*.yml',
    'lib/**/*.rb'
  ]
  s.test_files = Dir['spec/**/*.rb']
  s.extra_rdoc_files = ['MIT-LICENSE.md', 'README.md']

  s.add_dependency 'public_suffix', '~> 3.0'
  s.add_dependency 'rubocop', '~> 0.51.0'

  s.add_development_dependency 'bundler', '~> 1.15'
end
