require_relative "console/user_console"

namespace :twitter do
  task :console do
    Twitter::UserConsole.new.run
  end
end

namespace :test do
  task :run do
    exec("rspec --color lib/tweet_spec/*_spec.rb && " + 
         "rspec --color console/*_spec.rb && " + 
				 "rspec --color network/*_spec.rb")
  end
end

task :default => "twitter:console"