class CreateNames < ActiveRecord::Migration[7.1]
  def change
    create_table :names do |t|
      t.string :value

      t.timestamps
    end
  end
end
