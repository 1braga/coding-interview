require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { is_expected.to have_many(:tweets) }
    it { is_expected.to belong_to(:company) }
    it { is_expected.to validate_presence_of(:display_name) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
  end
end
