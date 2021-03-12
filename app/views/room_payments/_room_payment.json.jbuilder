json.extract! room_payment, :id, :payment_number, :status, :paid_at, :cost, :service, :booking_id, :user_id, :created_at, :updated_at
json.url room_payment_url(room_payment, format: :json)
