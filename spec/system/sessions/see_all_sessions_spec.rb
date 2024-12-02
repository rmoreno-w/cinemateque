require 'rails_helper'

describe 'Listing all movie sessions for a movie theater' do
  it 'with success' do
    movie_theater = FactoryBot.create(:movie_theater, name: 'Cine Paradiso')
    room = FactoryBot.create(:room, name: 'Sala Master')
    movie = FactoryBot.create(:movie, title: 'Terror em Alto Mar', year: 1993)
    user = FactoryBot.create(:user, email: 'joao@email.com', password: '123456789')
    first_session = Session.create!(room: room, movie: movie, weekday: 0, start_time: '19:00')
    second_session = Session.create!(room: room, movie: movie, weekday: 1, start_time: '20:00')
    login_as user

    visit root_path
    save_page
    within('nav') do
      click_on 'Cinemas'
    end
    click_on 'Sessões do Cinema'

    expect(page).to have_content 'Terror em Alto Mar'
    expect(page).to have_content 'Segunda-Feira - 20:00'
    expect(page).to have_content 'Domingo - 20:00'
  end
end
