class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items

  validates :first_name, presence: true, length: { minimum: 3, maximum: 100,
    too_short: "Minimum %{count} caractères.",
    too_long: "Seulement %{count} caractères autorisés." }
  validates :family_name, presence: true, length: { minimum: 3, maximum: 100,
    too_short: "Minimum %{count} caractères.",
    too_long: "Seulement %{count} caractères autorisés." }
  validates :email, presence: true
  validates :address, presence: true, length: { minimum: 3, maximum: 300,
    too_short: "Minimum %{count} caractères.",
    too_long: "Seulement %{count} caractères autorisés." }
  validates :start_at, presence: true
  validate :start_at_cannot_be_in_the_past
  validates :pay_method, length: { maximum: 100,
    too_long: "Seulement %{count} caractères autorisés." }
  validates :paid, inclusion: [true, false]

  def total_amount
    total = 0

    line_items.each do |item|
      total += item.total_price
    end

    total
  end

  protected

  def start_at_cannot_be_in_the_past
    if start_at.present? && start_at < Date.today
      errors.add(:start_at, "Ne peut pas être dans le passé")
    end
  end
end
