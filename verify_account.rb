require_relative "./twitter"

def verify_account
  path = "1.1/account/verify_credentials.json"
  address = Twitter::Network.create_address(path)
  http = Twitter::Network.create_http(address)
  request = Twitter::Network.create_authorized_request(http, address)
  response = Twitter::Network.execute_http(http, request)

  puts "The response is #{response.code}"
end

verify_account
