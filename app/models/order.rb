# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id                         :bigint           not null, primary key
#  first_name                 :string           default("")
#  email                      :string
#  address                    :text
#  pay_method                 :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  family_name                :string           default(""), not null
#  start_at                   :datetime
#  paid                       :boolean          default(FALSE)
#  country                    :string           default(""), not null
#  city                       :string           default(""), not null
#  zip_code                   :string           default(""), not null
#  stripe_payment_intent_id   :string
#  stripe_customer_id         :string
#  stripe_checkout_session_id :string
#
class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  validates :first_name, presence: true, length: {minimum: 3, maximum: 100,
                                                  too_short: "Minimum %{count} caractères.",
                                                  too_long: "Seulement %{count} caractères autorisés."}
  validates :family_name, presence: true, length: {minimum: 3, maximum: 100,
                                                   too_short: "Minimum %{count} caractères.",
                                                   too_long: "Seulement %{count} caractères autorisés."}
  validates :email, presence: true
  validates :address, presence: true, length: {minimum: 3, maximum: 300,
                                               too_short: "Minimum %{count} caractères.",
                                               too_long: "Seulement %{count} caractères autorisés."}
  validates :city, presence: true, length: {minimum: 3, maximum: 100,
                                            too_short: "Minimum %{count} caractères.",
                                            too_long: "Seulement %{count} caractères autorisés."}
  validates :country, presence: true, length: {minimum: 3, maximum: 100,
                                               too_short: "Minimum %{count} caractères.",
                                               too_long: "Seulement %{count} caractères autorisés."}
  validates :zip_code, presence: true, length: {minimum: 3, maximum: 8,
                                                too_short: "Minimum %{count} caractères.",
                                                too_long: "Seulement %{count} caractères autorisés."}
  validates :start_at, presence: true
  validate :start_at_cannot_be_in_the_past
  validates :pay_method, length: {maximum: 100,
                                  too_long: "Seulement %{count} caractères autorisés."}
  validates :paid, inclusion: [true, false]
  validates :stripe_payment_intent_id, length: {maximum: 100}
  validates :stripe_checkout_session_id, length: {maximum: 100}
  validates :stripe_customer_id, length: {maximum: 100}

  def full_name
    "#{self.first_name} #{self.family_name}"
  end

  def total_amount
    total = 0

    line_items.each do |item|
      total += item.total_price
    end

    total
  end

  def end_at
    total_duration_of_stay = 0

    line_items.each do |item|
      total_duration_of_stay += item.duration_of_stay
    end

    start_at + total_duration_of_stay.days
  end

  def stripe_order_name
    stripe_order_name = ""

    line_items.each do |item|
      stripe_order_name += "#{item.quantity} x #{item.product.name}\n"
    end

    stripe_order_name
  end

  protected

  def start_at_cannot_be_in_the_past
    errors.add(:start_at, "Ne peut pas être dans le passé") if start_at.present? && start_at < Date.today
  end


  private

  def first_available_start_date
    paid_orders = Order.where(paid: true)
  end
end
