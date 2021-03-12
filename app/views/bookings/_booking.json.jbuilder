json.extract! booking, :id, :status, :cost, :start, :room_id, :client_id, :created_at, :updated_at
json.url booking_url(booking, format: :json)
