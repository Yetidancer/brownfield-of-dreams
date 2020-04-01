require 'rails_helper'

describe 'As a logged in user' do
  describe 'when I visit my dashboard' do
    describe 'I should see all of my bookmarked videos.' do
      it 'The bookmarked videos are organized by tutorial and ordered by position', :vcr do
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

        visit dashboard_path

        within('#bookmark-1') do
          expect(page).to have_content('The Bunny Ears Technique: Part 2')
        end
        within('#bookmark-2') do
          expect(page).to have_content('The Bunny Ears Technique')
        end

        within('#bookmark-3') do
          expect(page).to have_content('The Bunny Ears Technique: Part 4')
        end

        within('#bookmark-4') do
          expect(page).to have_content('The Bunny Ears Technique: Part 3')
        end
      end
    end
  end
end
