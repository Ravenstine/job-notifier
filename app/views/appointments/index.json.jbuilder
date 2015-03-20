json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :name, :person, :company, :description, :time, :user_id
  json.url appointment_url(appointment, format: :json)
end
