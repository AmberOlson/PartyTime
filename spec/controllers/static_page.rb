require 'spec_helper'

describe StaticPagesController do
  describe 'GET home' do

    it 'renders the index template' do
      get 'home'
      expect(response).to render_template('home')
    end
  end

end
