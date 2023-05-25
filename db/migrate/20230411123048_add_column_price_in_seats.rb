class AddColumnPriceInSeats < ActiveRecord::Migration[6.1]
  def change
    add_column :seats, :price, :integer
  end
end
