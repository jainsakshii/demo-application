# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
    @theatres = Theatre.all
    @movies = Movie.all
  end
end