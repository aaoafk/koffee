class AddUserIdToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :user_id, :string
  end
end
