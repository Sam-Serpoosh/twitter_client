require 'logger'

module Twitter
  class Logger
    def initialize
      logfile = File.expand_path("../log/tweet_log.json", 
                                 File.dirname(__FILE__))
      @logger = ::Logger.new(logfile)
    end

    def log_response(response)
      log_text = "Current Response:\n"
      log_text += "#{"-" * 20}\n"
      log_text += "#{response}\n"
      log_text += "#{"*" * 40}\n"
      @logger.debug(log_text)
    end
  end
end
