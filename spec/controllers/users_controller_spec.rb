require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET redirect_page" do
    it "sets the cookies" do
      request.cookies[:membership_id] = 2
      get :redirect_page, :membership_id => 1
      expect(response.cookies["membership_id"]).to eq("1")
    end
  end

end
