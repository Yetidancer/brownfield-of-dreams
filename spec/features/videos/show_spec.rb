require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I visit the videos index page' do
		it 'I see a list of videos ' do
			tutorial = create(:tutorial)
			video1 = tutorial.videos.create!(title: "Title 1", description: "Description 1")

			visit "/tutorials/#{tutorial.id}/videos/#{video1.id}"

			expect(current_path).to eq("/tutorials/#{tutorial.id}/videos/#{video1.id}")
			expect(page).to have_content(video1.title)
		end
	end
end
