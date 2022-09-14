json.extract! account, :id, :balance, :agency, :client_id, :created_at, :updated_at
json.url account_url(account, format: :json)
