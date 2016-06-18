require "rails_helper"

describe 'creating comments' do

  before do
    FactoryGirl.create(:event)
    login_user
  end

  def create_comment (options ={})
    options[:text] ||="I am excited to go to the party"

    visit '/events/1'
    expect(page).to have_content("Party11")
    fill_in "Add a comment:", with: options[:text]
    click_button "Create Comment"
  end

  it 'is successfully creates a comment and displays it on the events page' do
    create_comment
    expect(page).to have_content("I am excited to go to the party")
  end

  it "fails and shows an error message when the comment is too short" do
    create_comment text:'a'
    expect(page).to have_content("Error")
    expect(page).to_not have_content("I am excited to go to the party")
  end
end
