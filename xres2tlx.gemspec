# frozen_string_literal: true

require_relative "lib/xres2tlx/version"

Gem::Specification.new do |spec|
  spec.name = "xres2tlx"
  spec.version = Xres2tlx::VERSION
  spec.authors = ["Rory Dudley"]
  spec.email = ["rory.dudley@gmail.com"]

  spec.summary = "Xresources to Tilix"
  spec.description = "Convert Xresource colorschemes into Tilix colorschemes (mostly meant to be used with the Xresource files at https://github.com/mbadolato/iTerm2-Color-Schemes)."
  spec.homepage = "https://github.com/pinecat/xres2tlx"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pinecat/xres2tlx"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end