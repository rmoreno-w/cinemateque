class SessionsController < ApplicationController
  before_action :get_movie_theater

  def index
    @sessions = @movie_theater.sessions
  end

  def new
    @session = Session.new()
    @movies = Movie.all
    @rooms = @movie_theater.rooms
  end

  def create
    session_params = params.require(session).permit(:movie_id, :room_id, :start_time, :weekday)

    @session = Session.new(session_params)

    if @session.save
      redirect_to movie_theater_sessions(@movie_theater), notice: 'Sessão criada com sucesso'
    else
      flash.now[:alert] = "Erro ao criar sessão"
      render 'new'
    end
  end

  private
  def get_movie_theater
    movie_theater_id = params[:movie_theater_id]
    @movie_theater = MovieTheater.find(movie_theater_id)
  end
end