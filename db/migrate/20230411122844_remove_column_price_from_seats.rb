class RemoveColumnPriceFromSeats < ActiveRecord::Migration[6.1]
  def change
    remove_column :seats,:price, :string
  end
end
