Feature: Sending event invites
As a party planner
I want to invite people to my party and have RSVP system
an email inform them of the party
So my both me and my guest are informed of what is happening

Scenario: Amber an event planner wants to invite people to the party
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
When I go to the Invite Guest page
Then I should see "friends you already have!"

Scenario: Amber invites Alex, a Partytime user, to an event
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
And "Alex Tucker" is valid user
When I go to the Invite Guest page
And fill in "user_email" with "alextucker@gmail.com"
And press "Invite User"
Then I should see "alextucker@gmail.com" within the "invited" list
And "alextucker@gmail.com" should receive an email with body "You have been invited to"

Scenario: Amber invites a guest with invalid email to an event
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
When I go to the Invite Guest page
And fill in "user_email" with "alextuckr@h"
And press "Invite User"
Then I should see "error"


Scenario: Amber invites Alex, not a Partytime user, to an event
Given "Amber Olson" is valid user
And I am logged in
And I have created an event
When I go to the Invite Guest page
And fill in "user_email" with "alextucker@gmail.com"
And press "Invite User"
Then "alextucker@gmail.com" should receive an email with body "Welcome to partyTime.com"
