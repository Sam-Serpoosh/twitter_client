namespace :twitter do
  task :timeline do
    exec "ruby user_console.rb"
  end
end

namespace :test do
  task :run_all do
    exec "rspec --color lib/tweet_spec/*_spec.rb"
  end
end

task :default => "test:run_all"