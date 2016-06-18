require 'spec_helper'

  describe "Spec for user Sign Up" do
       it "should create new user account and redirect to their personal page" do
        visit new_user_registration_path
        email = "abcd@example.com"
        fill_in 'user_email', :with => email
        fill_in 'user_password', :with => "password"
        fill_in 'user_password_confirmation', :with => "password"
        click_button 'Sign up'
        expect(page).to have_content "Welcome! You have signed up successfully."
      end

  describe 'Spec for user logging in' do
    it "with valid credentials redirects user to their users page" do
      visit tests_path
      expect(page).to have_content("You need to sign in")
      User.create(email: "amberolson@trentu.ca", password: "password123", password_confirmation: "password123")
      fill_in 'Email', :with => "amberolson@trentu.ca"
      fill_in 'Password', :with => "password123"
      click_button "Log in"
      expect(page).to have_content "Signed in successfully."
      expect(page).to have_content "Profile Page"
    end

    it "with invalid credentials shows failure message" do
      visit tests_path
      expect(page).to have_content("You need to sign in")
      fill_in 'Email', :with => "invalide@email.ca"
      fill_in 'Password', :with => "password123"
      click_button "Log in"
      expect(page).to have_content "Invalid email or password."
    end
  end
end
