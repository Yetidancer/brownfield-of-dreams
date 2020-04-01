require 'rails_helper'

RSpec.describe 'As a Visitor' do
	describe 'When I visit the tutorials index page' do
		it 'I see a list of tutorials to choose from' do
			non_classroom_tutorials = create_list(:tutorial, 3)
			classroom_tutorial = create(:tutorial, classroom: true)
			user = User.create!(email: 'peasant@example.com', first_name: 'Lowly', last_name: 'Peasant', password:  "password", github_username: "Yetidancer")

			visit '/tutorials'

			expect(page).to have_content(non_classroom_tutorials.first.title)
			expect(page).to have_content(non_classroom_tutorials.last.title)
			expect(page).to_not have_content(classroom_tutorial.title)

			visit '/'

  		click_on "Sign In"

  		expect(current_path).to eq(login_path)

  		fill_in 'session[email]', with: user.email
  		fill_in 'session[password]', with: user.password

  		click_on 'Log In'

			visit '/tutorials'

			expect(page).to have_content(classroom_tutorial.title)
		end
	end
end
