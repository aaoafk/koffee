class AddNameToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :name, :string
  end
end
