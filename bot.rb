#!/usr/bin/env ruby
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key       =''
  config.consumer_secret    =''
  config.access_token       ='-'
  config.access_token_secret=''
end

client.search('%22world%22cup%22',result_type: 'recent').take(1).each do |tweet|
  client.update("@#{tweet.user.screen_name} SWEDEN!!!!", in_reply_to_status_id: tweet.id)
end
