require "rubygems"
require "oauth"
require_relative "../tweet/tweet_logger"
require_relative "./settings"

module Twitter
  module Network
    SCREEN_NAME = Settings::SCREEN_NAME
    CONSUMER_KEY = OAuth::Consumer.new(Settings::CONSUMER_KEY, 
                                       Settings::CONSUMER_SECRET)
    ACCESS_TOKEN = OAuth::Token.new(Settings::ACCESS_TOKEN, 
                                    Settings::ACCESS_TOKEN_SECRET)
    BASE_URL = "https://api.twitter.com/"

    def self.fetch_response(path, query = nil)
      address = create_address(path, query)
      http = create_http(address)
      request = create_authorized_request(http, address)
      response = execute_http(http, request)
      response.body
    rescue => e
      Twitter::Logger.new.log_exception(e)
      error_message(e.message)
    end

    def self.create_address(path, query = nil)
      address = BASE_URL + path
      query.nil? ? URI(address) : URI("#{address}?#{query}")
    end

    def self.create_query(params)
      URI.encode_www_form(params)
    end

    def self.create_http(address)
      http = Net::HTTP.new(address.host, address.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http
    end

    def self.create_authorized_request(http, address)
      request = Net::HTTP::Get.new(address.request_uri)
      request.oauth!(http, CONSUMER_KEY, ACCESS_TOKEN)
      request
    end

    def self.execute_http(http, request)
      http.start
      http.request(request)
    end

    def self.error_message(message)
      "{errors: #{message}}"
    end
  end
end