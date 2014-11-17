json.array!(@things) do |thing|
  json.extract! thing, :id, :parent_id, :user_id, :bounty, :text, :type, :url
  json.url thing_url(thing, format: :json)
end
