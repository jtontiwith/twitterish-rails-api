json.tweets do |json|
  json.array! @tweets, partial: 'tweets/tweet', as: :tweet
end

json.tweets_count @tweets_count