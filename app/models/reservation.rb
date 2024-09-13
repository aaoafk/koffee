class Reservation < ApplicationRecord
  belongs_to :name
  validates :day, presence: true, inclusion: { in: %w(Monday Tuesday Wednesday Thursday Friday) }
  validates :user_id, presence: true
  validate :max_five_reservations_per_day
  validate :one_reservation_per_name_per_day

  private

  def max_five_reservations_per_day
    if Reservation.where(day: day).count >= 5
      errors.add(:base, "Sorry! The pot is empty!")
    end
  end

  def one_reservation_per_name_per_day
    if Reservation.exists?(name: name, day: day)
      errors.add(:base, "You have already made a reservation for this day.")
    end
  end
end
