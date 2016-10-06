Feature: Singing up
As a party planner
I want register for PartyTime with my email and a secure password
So I can use the sites features safely


Scenario: User views signs up page to PartyTime
When I go to the signup page
Then I should see "Log in"

Scenario: User registers for PartyTime
When I go to the signup page
And fill in "Email" with "amberolson@trentu.ca"
And fill in "Password" with "Password11"
And fill in "Password confirmation" with "Password11"
And press "Sign up"
Then I should see "Welcome! You have signed up successfully."

Scenario: User registers for PartyTime with incorrect email
When I go to the signup page
And fill in "Email" with "amberolson"
And fill in "Password" with "Password11"
And fill in "Password confirmation" with "Password11"
And press "Sign up"
Then I should see "1 error prohibited this user from being saved: Email is invalid"

Scenario: User registers for PartyTime with password too short
When I go to the signup page
And fill in "Email" with "amberolson@trentu.ca"
And fill in "Password" with "P"
And fill in "Password confirmation" with "P"
And press "Sign up"
Then I should see "1 error prohibited this user from being saved: Password is too short"

Scenario: User registers for PartyTime with incorrect password  confirmation
When I go to the signup page
And fill in "Email" with "amberolson@trentu.ca"
And fill in "Password" with "password123"
And fill in "Password confirmation" with "password1"
And press "Sign up"
Then I should see "1 error prohibited this user from being saved: Password confirmation doesn't match"
