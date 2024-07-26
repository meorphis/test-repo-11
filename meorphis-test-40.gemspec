# frozen_string_literal: true

require_relative "lib/meorphis-test-40/version"

Gem::Specification.new do |s|
  s.name = "meorphis-test-40"
  s.version = MeorphisTest40::VERSION
  s.summary = "Ruby library to access the Meorphis Test 40 API"
  s.authors = ["Meorphis Test 40"]
  s.email = "support@acme.com"
  s.files = Dir["lib/**/*.rb"]
  s.extra_rdoc_files = ["README.md"]
  s.required_ruby_version = ">= 3.0.0"
  s.add_dependency "connection_pool"
  s.homepage = "https://rubydoc.info/github/stainless-sdks/meorphis-test-40-ruby"
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/stainless-sdks/meorphis-test-40-ruby"
  s.metadata["rubygems_mfa_required"] = "true"
end
