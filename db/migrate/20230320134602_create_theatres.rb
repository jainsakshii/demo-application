class CreateTheatres < ActiveRecord::Migration[6.1]
  def change
    create_table :theatres do |t|
      t.string :name
      t.bigint :theatre_administrator_id
      t.string :contact_number

      t.timestamps
    end
  end
end
