class AddColumnToTheatres < ActiveRecord::Migration[6.1]
  def change
    add_column :theatres, :venue, :string
  end
end
