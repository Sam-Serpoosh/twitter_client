require_relative "./commenter"

user_console = "user_console.rb"
commenter = Commenter.new

namespace :twitter do
  task :console do
    exec "ruby #{user_console}"
  end
end

namespace :test do
  task :run_all do
    commenter.comment_last_line(user_console)
    exec("rspec --color lib/tweet_spec/*_spec.rb && " + 
         "rspec --color ./*_spec.rb")
    sleep 2000
    commenter.uncomment_last_line(user_console)
  end
end

task :default => "test:run_all"