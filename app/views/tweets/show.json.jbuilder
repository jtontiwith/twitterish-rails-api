json.tweet do |json|
  json.partial! 'tweets/tweet', tweet: @tweet
end