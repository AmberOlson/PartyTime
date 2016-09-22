FactoryGirl.define do

  factory :comment do
    text 'MyTextaboutaparty'
    event_id 1
    user_id 1
  end

  factory :event do
    title 'Party11'
    street_number 11
    route 'street'
    provence 'CA'
    city 'San_Francisco'
    country 'Canada'
    postal_code 'M5A 4R1'
    date '2015-05-09'
    time '2000-01-01 21:22:00 UTC'
    description 'party'
    lat '43.6428836'
    lng '-79.40251109999997'

  end

  factory :membership do
    event_id 1
    user_id 1
    admin true
    status Membership::RSVP_INVITED
    invitiation_token 'ABCTOKEN'
  end

  factory :relationship do
    user_id 1
    friend_id 2
    classification Relationship::REL_FAMILY
  end

  factory :user do
    # sequence(:email) { |n| 'user#{n}@example.com' }
    email 'user1@example.com'
    password 'PartyTime1'
    password_confirmation 'PartyTime1'
  end
end
