require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I log in I am sent to my dashboard' do
		it 'I can see Account Details' do

			user = create(:user)

			visit '/'

			click_on "Sign In"

			expect(current_path).to eq(login_path)

			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password

			click_on 'Log In'

			expect(current_path).to eq(dashboard_path)
			expect(page).to have_content("Account Details")
		end
	end
end
