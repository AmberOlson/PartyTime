Feature: Singing up
As a party planner
I want register for PartyTime with my email and a secure password
So I can use the sites features safely

Scenario: Amber views signs up page to PartyTime
When she visits the signup page
Then she will see "Log in"

Scenario: Amber registers for PartyTime
When she visits the signup page
And fills in the "Email" with "amberolson@trentu.ca"
And fills in the "Password" with "Password11"
And fills in the "Password confirmation" with "Password11"
And clicks the button "Sign up"
Then she will see "Welcome! You have signed up successfully."

Scenario: Amber registers for PartyTime with incorrect email
When she visits the signup page
And fills in the "Email" with "amberolson"
And fills in the "Password" with "Password11"
And fills in the "Password confirmation" with "Password11"
And clicks the button "Sign up"
Then she will see "1 error prohibited this user from being saved: Email is invalid"

Scenario: Amber registers for PartyTime with password too short
When she visits the signup page
And fills in the "Email" with "amberolson@trentu.ca"
And fills in the "Password" with "P"
And fills in the "Password confirmation" with "P"
And clicks the button "Sign up"
Then she will see "1 error prohibited this user from being saved: Password is too short"

Scenario: Amber registers for PartyTime with incorrect password  confirmation
When she visits the signup page
And fills in the "Email" with "amberolson@trentu.ca"
And fills in the "Password" with "password123"
And fills in the "Password confirmation" with "password1"
And clicks the button "Sign up"
Then she will see "1 error prohibited this user from being saved: Password confirmation doesn't match"
