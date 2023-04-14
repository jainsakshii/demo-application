class RemoveColumnSeatIdFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_reference :bookings, :seat, index: true, foreign_key: true
  end
end
