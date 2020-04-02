require 'rails_helper'

RSpec.describe 'As an Admin' do
	describe 'I can create a new tutorial' do
		it 'through the new tutorial form ' do
			admin = create(:admin)
			tutorial_params = {title: "Hello Moto", description: "Old Cell PHone Chimes", thumbnail: "https://i.ytimg.com/vi/XzJ1WnFTVds/maxresdefault.jpg"}

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			visit "/admin/dashboard"

			expect(page).to have_link("New Tutorial")

			click_on "New Tutorial"

			expect(current_path).to eq("/admin/tutorials/new")

			title = tutorial_params[:title]
			description = tutorial_params[:description]
			thumbnail = tutorial_params[:thumbnail]

			fill_in 'tutorial_title', with: title
			fill_in 'tutorial_description', with: description
			fill_in 'tutorial_thumbnail', with: thumbnail

			click_on "Save"

			new_tutorial = Tutorial.last.id

			expect(current_path).to eq("/tutorials/#{new_tutorial}")
			expect(page).to have_content("Successfully created tutorial.")
		end

		it 'through the new tutorial form unless the infromation is inaccurate ' do
			admin = create(:admin)
			tutorial_params = {title: "Hello Moto", description: "Old Cell PHone Chimes", thumbnail: "https://i.ytimg.com/vi/XzJ1WnFTVds/maxresdefault.jpg"}

			allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

			visit "/admin/dashboard"

			expect(page).to have_link("New Tutorial")

			click_on "New Tutorial"

			expect(current_path).to eq("/admin/tutorials/new")

			title = tutorial_params[:title]
			description = tutorial_params[:description]
			thumbnail = tutorial_params[:thumbnail]

			fill_in 'tutorial_title', with: title
			fill_in 'tutorial_description', with: " "
			fill_in 'tutorial_thumbnail', with: thumbnail

			click_on "Save"

			expect(current_path).to eq("/admin/tutorials/new")
			expect(page).to have_content("Title can't be blank")
			expect(page).to have_content("Description can't be blank")

		end
	end

	describe 'I can add tags to tutorials' do
	  it 'clicks on the add tag on a tutoral' do
	    admin = create(:user, role: 1)
	    tutorial = create(:tutorial)
	    video1 = create(:video, tutorial_id: tutorial.id)

	    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

	    visit "/admin/dashboard"

	    within(first(".admin-tutorial-card")) do
	      click_on 'Edit'
	    end

	    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

	    fill_in'tutorial[tag_list]', with: "Ruby"
	    click_on "Update Tags"
	    visit root_path

	    within(".categories") do
	      expect(page).to have_content("Ruby")
	    end

	    within(".categories") do
	      click_on "Ruby"
	    end

	    expect(current_path).to eq("/tags/Ruby")
	  end
	end
end
