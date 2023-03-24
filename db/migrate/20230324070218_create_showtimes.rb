class CreateShowtimes < ActiveRecord::Migration[6.1]
  def change
    create_table :showtimes do |t|
      t.string :name
      t.time :schedule
      t.belongs_to :screen, null: false, foreign_key: true

      t.timestamps
    end
  end
end
