json.array!(@highlights) do |highlight|
  json.extract! highlight, :id, :user_id, :description
  json.url highlight_url(highlight, format: :json)
end
