require 'logger'

module Twitter
  class Logger
    def initialize
      dev_log = File.expand_path("../log/development.log", 
                                 File.dirname(__FILE__))
      @logger = ::Logger.new(dev_log)
    end

    def log_response(response)
      log_text = "RESPONSE:\n"
      log_text += "#{"-" * 20}\n"
      log_text += "#{response}\n"
      log_text += "#{"*" * 40}\n"
      log_text += "RESPONSE-END"
      @logger.debug(log_text)
    end

    def log_exception(exception)
      log_text = "ERROR: #{exception.class.name}\n"
      log_text += "MESSAGE: #{exception.message}\n"
			log_text += "BACKTRACE:\n#{exception.backtrace}"
      log_text += "ERROR-END"
      @logger.error(log_text)
    end
  end
end
