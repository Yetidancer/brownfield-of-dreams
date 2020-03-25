require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I visit the videos index page' do
		it 'I see a list of videos ' do
			tutorial = create(:tutorial)
			video1 = tutorial.videos.create!(title: "Title 1", description: "Description 1")
			video2 = tutorial.videos.create!(title: "Title 2", description: "Description 2")

			visit "/tutorials/#{tutorial.id}/videos"

			expect(current_path).to eq("/tutorials/#{tutorial.id}/videos")
			expect(page).to have_content(video1.title)
			expect(page).to have_content(video2.title)
		end
	end
end
