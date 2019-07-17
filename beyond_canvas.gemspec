lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beyond_canvas/version"

Gem::Specification.new do |spec|
  spec.name          = "beyond_canvas"
  spec.version       = BeyondCanvas::VERSION
  spec.authors       = ["Unai Abrisketa"]
  spec.email         = ["u.abrisketa@epages.com"]

  spec.summary       = "Open-source framework that provides CSS styles"
  spec.description   = <<-DESC
    Beyond Canvas is an open-source framework that provides CSS styles for apps
    designed and developed for the online shop software Beyond
  DESC
  spec.homepage      = "https://github.com/ePages-de/beyond_canvas"

  spec.files         = `git ls-files`.split("\n")

  spec.add_dependency "bourbon",    "~> 5.1"
  spec.add_dependency "neat",       "~> 3.0"
  spec.add_dependency "slim-rails", "~> 3.2"
  spec.add_dependency "inline_svg", "~> 1.5"
end
