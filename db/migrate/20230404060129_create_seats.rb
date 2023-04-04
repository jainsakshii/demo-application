class CreateSeats < ActiveRecord::Migration[6.1]
  def change
    create_table :seats do |t|
      t.boolean :availablity_status
      t.string :price
      t.references :showtime, null: false, foreign_key: true

      t.timestamps
    end
  end
end
