require_relative "lib/taql/version"

Gem::Specification.new do |spec|
  spec.name = "taql"
  spec.version = Taql::VERSION
  spec.authors = ["Ariel Rzezak"]
  spec.email = ["arzezak@gmail.com"]

  spec.summary = "Tableize Rails SQL queries"
  spec.description = "Taql allows you to pretty print SQL table queries in Rails."
  spec.homepage = "https://github.com/arzezak/taql"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  spec.files = Dir["*.gemspec", "*.{md,txt}", "Rakefile", "{bin,exe,lib}/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
