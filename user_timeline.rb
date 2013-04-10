require_relative "./twitter"

def user_timeline
  path = "1.1/statuses/user_timeline.json"
  query = Twitter::Network.create_query(
    "screen_name" => Twitter::Network::SCREEN_NAME,
    "count" => 30)
  address = Twitter::Network.create_address(path, query)
  http = Twitter::Network.create_http(address)
  request = Twitter::Network.create_authorized_request(http, address)
  response = Twitter::Network.execute_http(http, request)
  response.body #timeline JSON collection
end

user_timeline
