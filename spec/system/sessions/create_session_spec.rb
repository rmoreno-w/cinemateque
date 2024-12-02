require 'rails_helper'

describe 'Create a movie sessions for a movie theater' do
  it 'but first has to be logged in' do
    room = FactoryBot.create(:room, name: 'Sala Master')
    movie = Movie.create!(title: 'Terror em Alto Mar', year: 1993, plot: 'Um plot twist', director: 'Steven Spielberg')
    user = FactoryBot.create(:user, email: 'joao@email.com', password: '123456789')

    visit new_movie_theater_session_path(room.movie_theater)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
  end

  it 'with success' do
    room = FactoryBot.create(:room, name: 'Sala Master')
    movie = Movie.create!(title: 'Terror em Alto Mar', year: 1993, plot: 'Um plot twist', director: 'Steven Spielberg')
    user = FactoryBot.create(:user, email: 'joao@email.com', password: '123456789')
    login_as user

    visit root_path
    save_page
    within('nav') do
      click_on 'Cinemas'
    end
    click_on 'Cine Piloto'
    click_on 'Sessões do Cinema'
    click_on 'Criar Sessão'
    select 'Sala Master', from: 'Sala'
    select 'Terror em Alto Mar', from: 'Filme'
    select 'Segunda-feira', from: 'Dia da Semana'
    fill_in 'Horário de Início', with: '18:00'
    click_on 'Criar'

    expect(page).to have_content 'Sessão criada com sucesso'
    expect(page).to have_content 'Terror em Alto Mar - Domingo - 19:00'
  end
end
