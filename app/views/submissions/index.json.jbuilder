json.array!(@submissions) do |submission|
  json.extract! submission, :id, :data, :references, :user_id
  json.url submission_url(submission, format: :json)
end
