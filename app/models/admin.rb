# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Admin < ApplicationRecord
  belongs_to :user, inverse_of: :clients
  accepts_nested_attributes_for :user
end
