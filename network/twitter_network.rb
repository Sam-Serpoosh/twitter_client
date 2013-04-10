require "rubygems"
require "oauth"
require_relative "./settings"

module Twitter
  module Network
    SCREEN_NAME = Settings::SCREEN_NAME
    CONSUMER_KEY = OAuth::Consumer.new(Settings::CONSUMER_KEY, 
                                       Settings::CONSUMER_SECRET)
    ACCESS_TOKEN = OAuth::Token.new(Settings::ACCESS_TOKEN, 
                                    Settings::ACCESS_TOKEN_SECRET)
    BASE_URL = "https://api.twitter.com/"

    def self.create_address(path, query = nil)
      return URI("#{BASE_URL}#{path}?#{query}") if !query.nil?
      URI("#{BASE_URL}#{path}")
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
  end
end