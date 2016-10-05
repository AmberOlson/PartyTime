Feature: Singing up
As a
I want our users to be greeted when they visit our site
So that they have a better experience

Scenario: User views signs up page to PartyTime
When I go to the signup page
Then I see "Log in"

Scenario: User registers for PartyTime
When I go to the signup page
And fill in "Email" with "amberolson@trentu.ca"
And fill in "Password" with "Password11"
And fill in "Password confirmation" with "Password11"
And click button "Sign up"
Then I see "Welcome! You have signed up successfully."
