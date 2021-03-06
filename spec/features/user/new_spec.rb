require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'I can create a new user' do
		it 'by visiting the new form and filling it out correctly', :vcr do

			visit '/users/new'

			fill_in "user_email", with: "user@email.com"
			fill_in "user_first_name", with: "Users"
			fill_in "user_last_name", with: "Userson"
			fill_in "user_password", with: "password1"
			fill_in "user_password_confirmation", with: "password1"

			click_on "Create Account"

			expect(current_path).to eq("/users")
			# expect(page).to have_content("An email has been sent to your inbox. please check it now.")
		end

		it 'I can not make two users with the same log in' do
			user = User.create!(email: "user@email.com", password: 'password', first_name:'Jim', last_name: "Smith", role: 0)

			visit '/users/new'

			fill_in "user_email", with: "user@email.com"
			fill_in "user_first_name", with: "Users"
			fill_in "user_last_name", with: "Userson"
			fill_in "user_password", with: "password1"
			fill_in "user_password_confirmation", with: "password1"

			click_on "Create Account"

			expect(page).to have_content("Username already exists")
		end
	end
end
