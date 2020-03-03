# frozen_string_literal: true

################################################################################
# Setup
################################################################################

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

################################################################################
# RDoc
################################################################################

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'BeyondCanvasz'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'bundler/gem_tasks'

################################################################################
# Custom rake tasks
################################################################################

require 'colorize'

namespace :release do
  desc 'Update beyond_canvas_custom_styles.sass generator template to latest version'
  task :custom_styles do |_task, _args|
    ORIG = 'app/assets/stylesheets/beyond_canvas/settings/_variables.sass'
    DEST = 'lib/generators/templates/beyond_canvas_custom_styles.sass'

    dest_file = File.open(DEST, 'w')

    File.open(ORIG, 'r').each do |line|
      next if line.include?('!global')

      line.start_with?('$') ? dest_file.print('// ' + line.gsub(' !default', '')) : dest_file.print(line)
    end

    dest_file.close

    puts 'Ok'.green
  end
end
