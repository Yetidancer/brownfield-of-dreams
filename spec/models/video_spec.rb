require 'rails_helper'

RSpec.describe Video, type: :model do
	describe "Validations" do
		it {should validate_presence_of :title}
		it {should validate_presence_of :description}
	end

	describe 'Relationships' do
		it {should have_many :user_videos}
		it {should have_many(:users).through(:user_videos)}
		it {should belong_to :tutorial}
	end
end
