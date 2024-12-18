require 'rails_helper'

describe 'Listing all movie sessions for a movie theater' do
  it 'but first has to be logged in' do
    room = FactoryBot.create(:room, name: 'Sala Master')
    movie = Movie.create!(title: 'Terror em Alto Mar', year: 1993, plot: 'Um plot twist', director: 'Steven Spielberg')
    user = FactoryBot.create(:user, email: 'joao@email.com', password: '123456789')
    first_session = Session.create!(room: room, movie: movie, weekday: 0, start_time: '19:00')
    second_session = Session.create!(room: room, movie: movie, weekday: 1, start_time: '20:00')

    visit movie_theater_sessions_path(room.movie_theater)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(page).not_to have_content 'Terror em Alto Mar - Segunda-feira - 20:00'
    expect(page).not_to have_content 'Terror em Alto Mar - Domingo - 19:00'
  end

  it 'with success' do
    room = FactoryBot.create(:room, name: 'Sala Master')
    movie = Movie.create!(title: 'Terror em Alto Mar', year: 1993, plot: 'Um plot twist', director: 'Steven Spielberg')
    user = FactoryBot.create(:user, email: 'joao@email.com', password: '123456789')
    first_session = Session.create!(room: room, movie: movie, weekday: 0, start_time: '19:00')
    second_session = Session.create!(room: room, movie: movie, weekday: 1, start_time: '20:00')
    login_as user

    visit root_path
    save_page
    within('nav') do
      click_on 'Cinemas'
    end
    click_on 'Cine Piloto'
    click_on 'Sessões do Cinema'

    expect(page).to have_content 'Terror em Alto Mar - Domingo - 19:00'
    expect(page).to have_content 'Terror em Alto Mar - Segunda-feira - 20:00'
  end
end
