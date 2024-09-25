# frozen_string_literal: true

require_relative "lib/meorphis-test-40/version"

Gem::Specification.new do |s|
  s.name = "meorphis-test-40"
  s.version = MeorphisTest40::VERSION
  s.summary = "Ruby library to access the Meorphis Test 44 API"
  s.authors = ["Meorphis Test 44"]
  s.email = "support@acme.com"
  s.files = Dir["lib/**/*.rb"]
  s.extra_rdoc_files = ["README.md"]
  s.required_ruby_version = ">= 3.0.0"
  s.add_dependency "connection_pool"
  s.homepage = "https://rubydoc.info/github/meorphis/test-repo-11"
  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/meorphis/test-repo-11"
  s.metadata["rubygems_mfa_required"] = "true"
end
