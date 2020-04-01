require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I visit a Tutorials show page' do
		it 'I see that specific tutorials title' do
			tutorial = create(:tutorial)
			tutorial.videos.create(title: "How to tie your shoes", description: "One, Two, Three")

			visit "/tutorials/#{tutorial.id}"

			expect(current_path).to eq("/tutorials/#{tutorial.id}")
			expect(page).to have_content(tutorial.title)
		end
	end
end
