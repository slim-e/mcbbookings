# frozen_string_literal: true

json.extract! package, :id, :name, :duration_in_days, :price, :created_at, :updated_at
json.url package_url(package, format: :json)
