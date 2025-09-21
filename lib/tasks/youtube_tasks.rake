require "net/http"
require "uri"
require "json"

namespace :youtube do

  desc 'a youtube test'
  task test_one: :environment do
    channel_id = "UCDkEYb-TXJVWLvOokshtlsw" # judge napolitano

    uri = URI("https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=#{channel_id}&key=#{::YOUTUBE_KEY}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    puts! data, 'data'
  end

end
