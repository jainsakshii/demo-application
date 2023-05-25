# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @theatres = Theatre.all
    @movies = Movie.all
  end
  def show_bookings
    @personal_bookings = current_user.bookings
    @personal_bookings.each do |booking|
      @showtime_id = booking.showtime_id
      @showname = Showtime.find(@showtime_id).scheduleDate
    end

  end
end