require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I visit the video edit page' do
		before :each do
			@admin = create(:admin)

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

			@tutorial = create(:tutorial)
			@video1 = @tutorial.videos.create!(title: "Title 1", description: "Description 1")
		end

		it 'I can change the video spec' do

			visit "/admin/tutorials/#{@tutorial.id}/edit"

			expect(current_path).to eq("/admin/tutorials/#{@tutorial.id}/edit")

			within "#video-#{@video1.id}" do
				expect(page).to have_content("Edit")
				click_on "Edit"
			end

			expect(current_path).to eq("/admin/videos/#{@video1.id}/edit")

			fill_in :title, with: 'Video 2'

			click_on "Submit"

			expect(current_path).to eq("/admin/tutorials/#{@tutorial.id}/edit")

			expect(@video1.title).to eq('Title 1')
		end

		it 'I can not change the video spec if it is left blank' do

			visit "/admin/tutorials/#{@tutorial.id}/edit"

			expect(current_path).to eq("/admin/tutorials/#{@tutorial.id}/edit")

			within "#video-#{@video1.id}" do
				expect(page).to have_content("Edit")
				click_on "Edit"
			end

			expect(current_path).to eq("/admin/videos/#{@video1.id}/edit")

			fill_in :title, with: ''

			click_on "Submit"

			expect(current_path).to eq("/admin/videos/#{@video1.id}/edit")

			expect(page).to have_content("Invalid information entered try again")
		end
	end
end
