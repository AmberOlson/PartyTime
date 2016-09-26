require 'rails_helper'

describe 'deleting comments' do

  before do
    FactoryGirl.create(:event)
    login_user
  end

  it 'is successfully deletes a comment when you are the creater' do
    comment = FactoryGirl.create(:comment)
    visit '/events/1'
    expect(Comment.count).to eq(1)
    within("#comment_#{comment.id}") do
      click_link 'Destroy'
    end
    expect(Comment.count).to eq(0)
    expect(page).to_not have_content('MyTextaboutaparty')
  end
end
