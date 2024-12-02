class SessionsController < ApplicationController
  before_action :get_movie_theater

  def index
    @sessions = @movie_theater.sessions
    puts @sessions
  end

  private
  def get_movie_theater
    movie_theater_id = params[:movie_theater_id]
    @movie_theater = MovieTheater.find(movie_theater_id)
  end
end