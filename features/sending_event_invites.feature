Feature: Sending event invites
As a party planner
I want to invite people to my party and have an RSVP system
and have an email inform them of the party invite
So both me and my guest are informed of what is happening

Background:
Given "Amber Olson" is a logged in user
And she has an event

Scenario: Amber, an event planner, wants to invite people to the party
When she visits the Invite Guest page
Then she will see "friends you already have!"

Scenario: Amber invites Alex, a Partytime user, to an event
Given she wants to invite "Alex Tucker" a user of the site
When she visits the Invite Guest page
And fills in the email with "alextucker@gmail.com"
And clicks the button "Invite User"
Then she will see "alextucker@gmail.com" within the "invited" list
And "alextucker@gmail.com" should receive 2 emails
And I open the email
And they should see "You have been invited to an event" in the email subject
And they should see "You have been invited to" in the email body
And they click the first link in the email

Scenario: Amber invites a guest with invalid email to an event
When she visits the Invite Guest page
And fills in the email with "alextuckr@h"
And clicks the button "Invite User"
Then she will see "error"

Scenario: Amber invites Alex, not a Partytime user, to an event
When she visits the Invite Guest page
And fills in the email with "alextucker@gmail.com"
And clicks the button "Invite User"
Then "alextucker@gmail.com" should receive an email with body "Welcome to partyTime.com"