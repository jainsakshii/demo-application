class AddColumnOfStartDateAndEndDateToShowtime < ActiveRecord::Migration[6.1]
  def change
    add_column :showtimes, :start_date, :date
    add_column :showtimes, :end_date, :date
  end
end
