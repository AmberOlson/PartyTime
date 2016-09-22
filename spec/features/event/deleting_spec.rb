require 'spec_helper'

describe 'deleting events' do

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

  it 'ensures that the delete button works' do
    visit '/events/1'
    expect(page).to have_content('Party11')
    expect(Event.count).to eq(1)
    click_link 'Destroy'
    expect(page).to_not have_content(event.title)
    expect(page).to have_content('Profile Page')
    expect(Event.count).to eq(0)
  end
end
