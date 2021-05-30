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
  belongs_to :room

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
  validates :start_at, presence: {message: 'Veuillez modifier la date de début de stage.'}
  validate :start_at_cannot_be_in_the_past
  validates :end_at, presence: true
  validates :paid, inclusion: [true, false]
  validates :stripe_payment_intent_id, length: {maximum: 100}
  validates :stripe_checkout_session_id, length: {maximum: 100}
  validates :stripe_customer_id, length: {maximum: 100}
  validates :total_amount, presence: true
  validates :discounted_amount, presence: true #, numericality: {only_integer: true}
  validates :coupon, length: {maximum: 100,
                              too_long: "Seulement %{count} caractères autorisés."}


  def full_name
    "#{first_name} #{family_name}"
  end

  def stripe_order_name
    stripe_order_name = ""

    line_items.each do |item|
      stripe_order_name += "#{item.quantity} x #{item.product.name}\n"
    end

    stripe_order_name
  end

  def set_end_at
    start_at + total_duration_of_stay.days
  end

  protected

  def start_at_cannot_be_in_the_past
    errors.add(:start_at, "La date de début de stage ne peut pas être dans le passé") if start_at.present? && start_at < Date.today
  end

  private

  def total_duration_of_stay
    total_duration_of_stay = 0

    line_items.each do |item|
      total_duration_of_stay += item.duration_of_stay
    end

    total_duration_of_stay
  end
end
