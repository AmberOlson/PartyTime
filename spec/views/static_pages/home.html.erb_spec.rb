require 'spec_helper'

describe 'static_pages/home' do
  it 'displays welcome message' do
    allow(view).to receive(:user_signed_in?).and_return(false)
    render
    expect(rendered).to include('Welcome')
  end
end

describe 'layouts/_header' do
  before do
    allow(view).to receive(:user_signed_in?).and_return(false)
  end

  it 'displays log in link when not logged in' do
    render
    expect(rendered).to include('Log in')
    expect(rendered).to_not include('User Profile')
  end
end

describe 'layouts/_header' do
  before do
    assign(:user, User.create!(email: 'example@email.com', password: 'f4k3p455w0rd'))
    allow(view).to receive(:user_signed_in?).and_return(true)
    allow(view).to receive(:current_user).and_return(:user)
  end

  it 'displays User Profile link when logged in' do
    render
    expect(rendered).to include('Log Out')
  end
end
