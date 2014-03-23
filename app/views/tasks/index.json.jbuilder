json.array!(@tasks) do |task|
  json.extract! task, :title, :status
  json.url task_url(task, format: :json)
end