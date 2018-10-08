json.extract! diary, :id, :user_id, :body, :negaposi, :created_at, :updated_at
json.url diary_url(diary, format: :json)
