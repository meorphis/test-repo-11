# frozen_string_literal: true

require "minitest/test_task"
require "rubocop/rake_task"

task(default: [:test, :format])

Minitest::TestTask.create

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = %w[--fail-level E --autocorrect]
  if ENV.key?("CI")
    t.options += %w[--format github]
  end
end

RuboCop::RakeTask.new(:format) do |t|
  t.options = %w[--fail-level F --autocorrect --format offenses]
end

task(:build) do
  sh(*%w[gem build -- meorphis-test-40.gemspec])
end

task(release: [:build]) do
  sh(*%w[gem push], *FileList["meorphis-test-40-*.gem"])
end
