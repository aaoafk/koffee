class AddExpiredToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :expired, :boolean, default: false
  end
end
