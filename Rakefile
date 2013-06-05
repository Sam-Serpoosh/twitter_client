require 'rake/testtask'
require 'rspec/core/rake_task'
require_relative 'lib/console/user_console'

namespace :twitter do
  task :console do
    Twitter::UserConsole.new.run
  end
end

namespace :test do
  RSpec::Core::RakeTask.new(:unit) do |task|
    file_list = FileList["spec/**/*_spec.rb"]
    file_list = file_list.exclude("spec/integration_spec/*.rb")
    task.pattern = file_list
  end

  RSpec::Core::RakeTask.new(:integ) do |task|
    task.pattern = FileList["spec/integration_spec/*.rb"]
  end
end

desc "Run tests"
task :tests => ["test:unit", "test:integ"]

desc "Run What's Up?"
task :default => "twitter:console"