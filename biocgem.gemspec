# frozen_string_literal: true

require_relative "lib/biocgem/version"

Gem::Specification.new do |spec|
  spec.name = "biocgem"
  spec.version = Biocgem::VERSION
  spec.authors = ["kojix2"]
  spec.email = ["2xijok@gmail.com"]

  spec.summary = "biocgem command line tools"
  spec.description = "biocgem command line tools"
  spec.homepage = "https://github.com/ruby-on-bioc/biocgem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.files = Dir["*.{md,txt}", "{lib,exe,template}/**/*"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # spec.add_dependency "example-gem", "~> 1.0"
end
