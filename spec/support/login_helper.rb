module LoginHelpers
  def login_user
    User.create!(email: 'example@email.com', password: 'password123')
    visit new_user_session_path
    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: 'password123'
    click_button 'Log in'
    FactoryGirl.create(:membership)
  end
end
