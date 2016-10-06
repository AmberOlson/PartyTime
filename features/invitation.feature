Feature: Sending event invites
As a party planner
I want to invite people to my party
So that they know it is happening

Scenario: Amber invites Alex, a Partytime user, to an event
Given I am valid user
And I am logged in
And I have created an event
And Alex is a valid user
When I go to the Invite Guest page
And fill in "user_email" with "Tucker.al@gmail.com"
And click button "Invite User"
Then I see "tucker.al@gmail.com"

Scenario: Go to page
Given I am valid user
And I am logged in
And I have created an event
When I go to the Invite Guest page
Then I see "friends you already have!"
