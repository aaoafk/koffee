class Reservation < ApplicationRecord
  validates :name, presence: true
  validates :day, presence: true, inclusion: { in: %w(Monday Tuesday Wednesday Thursday Friday) }
  validates :user_id, presence: true
  validate :max_five_reservations_per_day

  private

  def max_five_reservations_per_day
    if Reservation.where(day: day).count > 5
      errors.add(:base, "Sorry! The pot is empty!")
    end
  end
end
