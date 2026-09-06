require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create do |task|
  task.test_prelude = 'require "swarf/probe"'
end

require "standard/rake"

task default: %i[test standard]
