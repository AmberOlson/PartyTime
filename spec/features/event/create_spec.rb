require 'rails_helper'

describe 'creating events' do

  let! (:user) { User.create!(email: 'example@email.com', password: 'password123') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'
  end

  def create_party(options = {})
    options[:title] ||= 'Party11'
    options[:street_number] ||= 11
    options[:route] ||= 'Street'
    options[:city] ||= 'City'
    options[:provence] ||= 'Provence'
    options[:postal_code] ||= 'm5a 4r1'
    options[:country] ||= 'Canada'

    options[:date] ||= '2015-05-09'
    options[:time] ||= '2000-01-01 21:22:00 UTC'
    options[:description] ||= 'This is a party that I am having'


    visit '/events/new'
    expect(page).to have_content('Create a new Event')
    fill_in 'Title', with: options[:title]
    fill_in 'event[street_number]', with: options[:street_number]
    fill_in 'event[route]', with: options[:route]
    fill_in 'event[city]', with: options[:city]
    fill_in 'event[provence]', with: options[:provence]
    fill_in 'event[postal_code]', with: options[:postal_code]
    fill_in 'event[country]', with: options[:country]
    fill_in 'Date', with: options[:date]
    fill_in 'Time', with: options[:time]
    fill_in 'Description', with: options[:description]
    click_button 'Submit'
  end

  it 'redirects to index after successfully creating event' do
    create_party
    expect(page).to have_content('Party11')
    visit user_path(user)
    within('.status_going') do
      expect(page).to have_content('Party11')
    end
  end

  it 'shows a error message when event form is filled out incorrectly' do
    expect(Event.count).to eq(0)
    create_party title: ''
    expect(page).to have_content('error')
    expect(Event.count).to eq(0)
    expect(page).to have_content('Create a new Event')
  end

end
