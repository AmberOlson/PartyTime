Feature: Sending event invites
As a party planner
I want to invite people to my party
So that they know it is happening

Scenario: Amber invites Alex, a Partytime user, to an event
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
And "Alex Tucker" is valid user
When I go to the Invite Guest page
And fill in "user_email" with "alextucker@gmail.com"
And click button "Invite User"
Then I see "alextucker@gmail.com"
And Alex should receive an email

Scenario: Go to page
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
When I go to the Invite Guest page
Then I see "friends you already have!"
