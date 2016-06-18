require 'spec_helper'

describe TestsController do


describe "GET index" do

    it "redirect to login when not signed in" do
      get "index"
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
