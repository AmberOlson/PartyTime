require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { belong_to(:event) }
  it { belong_to(:user) }
  it { should validate_presence_of(:text) }
  it { should validate_length_of(:text).is_at_least(2) }
end
