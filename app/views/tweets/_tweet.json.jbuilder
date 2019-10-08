json.(tweet, :slug, :body, :created_at, :updated_at)
json.author tweet.user, partial: 'profiles/profile', as: :user