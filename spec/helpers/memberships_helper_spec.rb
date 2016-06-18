require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the MembershipsHelper. For example:
#
# describe MembershipsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe MembershipsHelper, type: :helper do
  describe "#user_email" do
      context "when the user has a name" do
        it "returns the user's name" do
          user = FactoryGirl.create(:user, :name => "foo")
          membership = FactoryGirl.create(:membership)
          expect(helper.membership_email_or_name(membership, user)).to eq("foo")
        end
      end

      context "when the user has no name" do
        it "returns email" do
          user = FactoryGirl.create(:user)
          membership = FactoryGirl.create(:membership)
          expect(helper.membership_email_or_name(membership, user)).to eq("user1@example.com")
        end
      end
    end
end
