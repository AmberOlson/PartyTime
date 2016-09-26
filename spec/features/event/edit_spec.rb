require 'rails_helper'

describe 'editing events' do

  before do
    login_user
  end

  let!(:event) do
    Event.create(title: 'Party11',
                 street_number: 11,
                 route: 'Street',
                 city: 'City',
                 provence: 'Provence',
                 postal_code: 'm5a 4r1',
                 country: 'Canada',
                 date: '2015-05-09',
                 time: '2000-01-01 21:22:00 UTC',
                 description: 'party')
  end

  def edit_party(options = {})
    options[:title] ||= 'Change the Party'
    options[:street_number] ||= 11
    options[:route] ||= 'Street'
    options[:city] ||= 'City'
    options[:provence] ||= 'Provence'
    options[:postal_code] ||= 'm5a 4r1'
    options[:country] ||= 'Canada'
    options[:date] ||= '2015-05-09'
    options[:time] ||= '2000-01-01 21:22:00 UTC'
    options[:description] ||= 'This is a party that I am having'

    expect(page).to have_content('Party11')
    click_link 'Edit'
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

  it 'redirects after successfully editing event' do
    expect(page).to have_content('Profile Page')
    visit '/events/1'
    edit_party
    event.reload

    expect(page).to have_content('Event was successfully updated.')
    expect(event.title).to eq('Change the Party')
  end

  it 'shows a error message when event form is edit incorrectly' do
    expect(page).to have_content('Profile Page')
    visit '/events/1'
    edit_party title: ''
    event.reload

    expect(event.title).to eq('Party11')
    expect(page).to have_content('error')
  end
end
