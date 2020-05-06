# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'beyond_canvas/version'

Gem::Specification.new do |spec|
  spec.name        = 'beyond_canvas'
  spec.version     = BeyondCanvas::VERSION
  spec.authors     = ['Unai Abrisketa']
  spec.email       = ['u.abrisketa@epages.com']
  spec.homepage    = 'https://github.com/ePages-de/beyond_canvas'
  spec.summary     = 'Open-source framework that provides CSS styles'
  spec.description = <<-DESC
    Beyond Canvas is an open-source framework that provides CSS styles for apps
    designed and developed for the online shop software Beyond
  DESC
  spec.license = 'MIT'

  spec.files = Dir[
    '{app,config,db,lib}/**/*',
    'LICENSE',
    'Rakefile',
    'README.md'
  ]

  spec.add_dependency 'beyond_api'

  spec.add_dependency 'bourbon',         '~> 5.1'
  spec.add_dependency 'colorize',        '~> 0.8'
  spec.add_dependency 'http-accept',     '~> 2.1'
  spec.add_dependency 'inline_svg',      '~> 1.5'
  spec.add_dependency 'rails',           '~> 6.0.2', '>= 6.0.2.1'
  spec.add_dependency 'sassc-rails',     '~> 2.1'
  spec.add_dependency 'premailer-rails', '~> 1.11'

  spec.add_development_dependency 'rubocop', '~> 0.80.0'
end
