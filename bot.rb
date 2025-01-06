#!/usr/bin/env ruby
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key       ='xFJlm5IjO3MRypurChIWnojMY'
  config.consumer_secret    ='bDYsVKEnYTH0js7XAMRy8pXbNbbjuSeqGdK7oIWbrkuO8ovo8L'
  config.access_token       ='794853423573270528-9fMhHVfAPxDO2mELbsASdgqyOCGTLr8'
  config.access_token_secret='I4jmNIAbZXGIb3GgVmAsp0QhEUiKQxhFp0WJgQcVjZLh5'
end

client.search('%22world%22cup%22',result_type: 'recent').take(1).each do |tweet|
  client.update("@#{tweet.user.screen_name} SWEDEN!!!!", in_reply_to_status_id: tweet.id)
end
