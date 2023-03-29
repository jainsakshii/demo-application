class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :genre
      t.text :description

      t.timestamps
    end
  end
end
