require "colorize"
require "bundler/gem_tasks"

namespace :release do
  namespace :prepare do

    desc "Update beyond_canvas_custom_styles.sass generator template file to its latest version"
    task :custom_styles do |task, args|
      ORIG = "app/assets/stylesheets/settings/_variables.sass"
      DEST = "lib/generators/templates/beyond_canvas_custom_styles.sass"

      dest_file = File.open(DEST, 'w')
      File.open(ORIG, 'r').each do |line|
        next if line.include?("!global")
        line.start_with?("$") ? dest_file.print("// " + line.gsub(" !default", "")) : dest_file.print(line)
      end
      dest_file.close

      puts "Ok".green
    end
  end
end
