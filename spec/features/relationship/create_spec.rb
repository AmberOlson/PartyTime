describe 'creating relationship' do

  before do
    login_user
    User.create!(:email => "user1@example.com", :password => "password123")
    FactoryGirl.create(:event)
  end

  def invite_user(options ={})
    options[:user_email] ||="user1@example.com"

    visit '/events/1'
    click_link "Invite Guest"
    fill_in :user_email, with: options[:user_email]
    click_button "Invite User"
  end


  it "adds an initial friend invited to a list of your relationships" do
    invite_user
    visit '/events/1'
    click_link "Invite Guest"
    page.should have_css('div#classification_other', :text == "user1@example.com")
  end

end
