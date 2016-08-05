describe 'editing relationship' do

  before do
    login_user
    User.create!(:email => "user1@example.com", :password => "password123")
    FactoryGirl.create(:relationship)
    FactoryGirl.create(:relationship, :friend => "relationship2@email.com" )
    FactoryGirl.create(:relationship, :friend => "relationship3@email.com" )
    FactoryGirl.create(:event)
  end

  it "allows you to change the classification of relationship you have with frinds" do
    visit "/relationship/edit"
    expect(page).to have_content("user1@example.com")
    page.should have_css('div#classification_other', :text == 'user1@example.com')
    select 'Friend', :from => 'classification'
    check('relationship2@email.com')
    check('user1@example.com')
    click_button 'Update Friendship'

    visit '/events/1'
    visit "/relationship/edit"
    expect(page).to have_content("user1@example.com")
    page.should have_css('div#classification_friend', :text == 'user1@example.com')
    page.should have_css('div#classification_friend', :text == "relationship3@email.com")
    page.should have_css('div#classification_other', :text == "relationship2@email.com")
  end

end
