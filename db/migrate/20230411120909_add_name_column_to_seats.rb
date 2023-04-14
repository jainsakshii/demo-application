class AddNameColumnToSeats < ActiveRecord::Migration[6.1]
  def change
    add_column :seats, :name, :string
  end
end
