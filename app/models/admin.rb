class Admin < ApplicationRecord
  belongs_to :user, :inverse_of => :clients
  accepts_nested_attributes_for :user
end
