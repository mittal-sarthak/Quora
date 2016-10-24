json.extract! question, :id, :question_text, :user_id, :created_at, :updated_at
json.url question_url(question, format: :json)