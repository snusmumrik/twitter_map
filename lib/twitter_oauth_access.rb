require 'rubygems'
require 'oauth'
require 'twitter_oauth_patch'
require 'json'

CONSUMER_KEY = 'OjjD5RxhswwLO9P43w2dSw' # ←ここを書き換える
CONSUMER_SECRET = '1ztPFGhS5sCmbuCKRtWOIvOp2cK7leo3qsU3lDKJ4' # ←ここを書き換える
ACCESS_TOKEN = '96296212-AJZLL0RdhgcqDgtGPXOdwhf3Dt9vlECK8a1H8WIMJ' # ←ここを書き換える
ACCESS_TOKEN_SECRET = 'OtjJj55DYQYQAtn5GqtTYwV9JIDIsEx5LilNmpI' # ←ここを書き換える

# 下準備
consumer = OAuth::Consumer.new(
  CONSUMER_KEY,
  CONSUMER_SECRET,
  :site => 'http://twitter.com'
)

access_token = OAuth::AccessToken.new(
  consumer,
  ACCESS_TOKEN,
  ACCESS_TOKEN_SECRET
)

# タイムラインを取得して時系列順に表示
response = access_token.get('http://twitter.com/statuses/friends_timeline.json')
JSON.parse(response.body).reverse_each do |status|
  user = status['user']
  puts "#{user['name']}(#{user['screen_name']}): #{status['text']}"
end

# Tweetの投稿
# response = access_token.post(
#   'http://twitter.com/statuses/update.json',
#   'status'=> 'このメッセージはOAuth認証を通して投稿しています。'
# )