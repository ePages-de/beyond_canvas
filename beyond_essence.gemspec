lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "beyond_essence/version"

Gem::Specification.new do |spec|
  spec.name          = "beyond_essence"
  spec.version       = BeyondEssence::VERSION
  spec.authors       = ["Unai Abrisketa"]
  spec.email         = ["u.abrisketa@epages.com"]

  spec.summary       = "Open-source framework that provides CSS styles"
  spec.description   = <<-DESC
    Beyond Essence is an open-source framework that provides CSS styles for apps
    designed and developed for the online shop software Beyond
  DESC
  spec.homepage      = "https://github.com/ePages-de/beyond-ruby_sdk"

  spec.files         = `git ls-files`.split("\n")
end
