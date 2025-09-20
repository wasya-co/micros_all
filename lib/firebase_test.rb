require "net/http"
require "uri"
require "json"
require "googleauth"

service_account_file = "access/service-account.json"
scope = "https://www.googleapis.com/auth/firebase.messaging"

authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
  json_key_io: File.open(service_account_file),
  scope: scope,
)

authorizer.fetch_access_token!
puts "Access Token: #{authorizer.access_token}"


uri = URI("https://fcm.googleapis.com/v1/projects/ish-notifier/messages:send")
header = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{authorizer.access_token}"
}

body = {
  message: {
    token: "DEVICE_REGISTRATION_TOKEN",
    notification: {
      title: "Hello from Ruby",
      body: "This is a push notification!"
    }
  }
}

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = body.to_json

response = http.request(request)
puts! response.body, 'response.body'
