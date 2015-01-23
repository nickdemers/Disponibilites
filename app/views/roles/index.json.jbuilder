json.array!(@roles) do |role|
  json.extract! role, :id, :nom
  json.url role_url(role, format: :json)
end
