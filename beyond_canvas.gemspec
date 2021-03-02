# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'beyond_canvas/version'

Gem::Specification.new do |spec|
  spec.name        = 'beyond_canvas'
  spec.version     = BeyondCanvas::VERSION
  spec.authors     = [
    'Unai Abrisketa',
    'Kathia Salazar',
    'German San Emeterio'
  ]
  spec.email       = [
    'uabrisketa@epages.com',
    'ksalazar@epages.com',
    'gsanemeterio@epages.com'
  ]
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

  spec.required_ruby_version = '>= 2.5'

  spec.add_dependency 'attr_encrypted',  '~> 3.1'
  spec.add_dependency 'beyond_api',      '~> 0.11'
  spec.add_dependency 'bourbon',         '~> 5.1'
  spec.add_dependency 'colorize',        '~> 0.8'
  spec.add_dependency 'http-accept',     '~> 2.1'
  spec.add_dependency 'inline_svg',      '~> 1.5'
  spec.add_dependency 'jquery-rails',    '~> 4.4'
  spec.add_dependency 'jwt',             '~> 2.2'
  spec.add_dependency 'loaf',            '~> 0.9'
  spec.add_dependency 'premailer-rails', '~> 1.11'
  spec.add_dependency 'sassc-rails',     '~> 2.1'
  spec.add_dependency 'sprockets',       '>= 3.0', '< 4.1'

  spec.add_development_dependency 'rubocop-rails', '~> 2.5'
end
