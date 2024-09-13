class AddNameReferenceToReservations < ActiveRecord::Migration[7.1]
  def change
    add_reference :reservations, :name, null: false, foreign_key: true
  end
end
