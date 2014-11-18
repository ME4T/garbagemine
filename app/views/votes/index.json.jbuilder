json.array!(@votes) do |vote|
  json.extract! vote, :id, :user_id, :thing_id, :creative, :beautiful, :inspiring
  json.url vote_url(vote, format: :json)
end
