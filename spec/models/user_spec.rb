require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

	describe 'Relationships' do
		it {should have_many :user_videos}
		it {should have_many(:videos).through(:user_videos)}
	end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
	end

	describe 'methods' do
    it '.bookmarked_segments' do
      user = create(:user, token: ENV['TEST_KEY'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      tutorial = create(:tutorial)
      tutorial_2 = create(:tutorial)

      video_1 = create(:video, title: 'The Bunny Ears Technique', tutorial: tutorial, position: 1)
      video_2 = create(:video, title: 'The Bunny Ears Technique: Part 2', tutorial: tutorial, position: 0)
      video_3 = create(:video, title: 'The Bunny Ears Technique: Part 3', tutorial: tutorial_2, position: 1)
      video_4 = create(:video, title: 'The Bunny Ears Technique: Part 4', tutorial: tutorial_2, position: 0)

      create(:user_video, user: user, video: video_1)
      create(:user_video, user: user, video: video_2)
      create(:user_video, user: user, video: video_3)
      create(:user_video, user: user, video: video_4)

      result = user.bookmarked_segments
      expect(result).to eq([video_2, video_1, video_4, video_3])
    end
  end
end
