Feature: Sending event invites
As a party planner
I want to invite people to my party and have RSVP system
and have an email inform them of the party
So my both me and my guest are informed of what is happening

Scenario: Amber an event planner wants to invite people to the party
Given "Amber Olson" is a logged in user
And she has an event
When she visits the Invite Guest page
Then she will see "friends you already have!"

Scenario: Amber invites Alex, a Partytime user, to an event
Given "Amber Olson" is a logged in user
And she has an event
And she wants to invite "Alex Tucker" a user of the site
When she visits the Invite Guest page
And fills in the email with "alextucker@gmail.com"
And clicks the button "Invite User"
Then she will see "alextucker@gmail.com" within the "invited" list
And "alextucker@gmail.com" should receive an email with body "You have been invited to"

Scenario: Amber invites a guest with invalid email to an event
Given "Amber Olson" is a logged in user
And she has an event
When she visits the Invite Guest page
And fills in the email with "alextuckr@h"
And clicks the button "Invite User"
Then she will see "error"

Scenario: Amber invites Alex, not a Partytime user, to an event
Given "Amber Olson" is a logged in user
And she has an event
When she visits the Invite Guest page
And fills in the email with "alextucker@gmail.com"
And clicks the button "Invite User"
Then "alextucker@gmail.com" should receive an email with body "Welcome to partyTime.com"
