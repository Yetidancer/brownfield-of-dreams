require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I visit a Tutorials show page as a visitor' do
		it 'I see that specific tutorials title' do
			tutorial = create(:tutorial)
			tutorial.videos.create(title: "How to tie your shoes", description: "One, Two, Three")

			visit "/tutorials/#{tutorial.id}"

			expect(current_path).to eq("/tutorials/#{tutorial.id}")
			expect(page).to have_content(tutorial.title)
		end
	end

	describe 'When I visit a Tutorials show page as a user' do
		it 'unless I am logged in I cannot see that specific tutorials title if it is a classroom tutorial' do
			classroom_tutorial = create(:tutorial, classroom: true)
			classroom_tutorial.videos.create(title: "How to tie your shoes", description: "One, Two, Three")
			user = User.create!(email: 'peasant@example.com', first_name: 'Lowly', last_name: 'Peasant', password:  "password", github_username: "Yetidancer")

			visit "/tutorials/#{classroom_tutorial.id}"

			expect(current_path).to eq("/tutorials/#{classroom_tutorial.id}")
			expect(page).to_not have_content(classroom_tutorial.title)
			expect(page).to have_content("You must log in to view this tutorial.")

			visit '/'

  		click_on "Sign In"

  		expect(current_path).to eq(login_path)

  		fill_in 'session[email]', with: user.email
  		fill_in 'session[password]', with: user.password

  		click_on 'Log In'

			visit "/tutorials/#{classroom_tutorial.id}"

			expect(page).to have_content(classroom_tutorial.title)
		end
	end
end
