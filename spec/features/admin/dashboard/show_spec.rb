require 'rails_helper'

RSpec.describe 'As a Admin' do
	describe "I can visit the admin dashboard, I can " do
		before :each do
			@admin = create(:admin)
	    create_list(:tutorial, 2)

	    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

	    visit "/admin/dashboard"

			json_response = File.read('spec/fixtures/.json')
			stub_request(:get, "https://developer.github.com/v3/repos/#list-your-repositories").
        to_return(status: 200, body: "")
		end

	  it "see all tutorials" do

	    expect(page).to have_css(".admin-tutorial-card", count: 2)
	  end

		it "I see a link to log into GitHub if I am not currently logged in" do

			expect(page).to have_link("Log into Github")

			click_on "Log into Github"

			expect(current_path).to eq("/admin/dashboard")

			# this should follow the "https://developer.github.com/v3/repos/#list-your-repositories"
			expect(page).to have_link("<FIRST REPO NAME>")
			expect(page).to have_link("<SECOND REPO NAME>")
			expect(page).to have_link("<THIRD REPO NAME>")
			expect(page).to have_link("<FOURTH REPO NAME>")
			expect(page).to have_link("<FITH REPO NAME>")
		end

		it "I see a link to log into GitHub if I am not currently logged in, and I do not see this path." do

			expect(page).to have_link("Log into Github")

			click_on "Log into Github"

			expect(current_path).to eq("/admin/dashboard")

			# this should follow the "https://developer.github.com/v3/repos/#list-your-repositories"
			expect(page).not_to have_link("<FIRST REPO NAME>")
			expect(page).not_to have_link("<SECOND REPO NAME>")
			expect(page).not_to have_link("<THIRD REPO NAME>")
			expect(page).not_to have_link("<FOURTH REPO NAME>")
			expect(page).not_to have_link("<FITH REPO NAME>")
		end

		it 'I only see my repositories not that of another user' do
			admin2 = create(:admin)

			click_on "Log Out"

			expect(current_path).to eq("/")

			click_on "Sign In"

			expect(current_path).to eq("/login")

			fill_in 'session[email]', with: admin2.email
			fill_in 'session[password]', with: admin2.password

			click_on 'Log In'

			expect(current_path).to eq(dashboard_path)

			# this should be the list of repos for the @admin in the before each block.
			expect(page).not_to have_link("<FIRST REPO NAME>")
			expect(page).not_to have_link("<SECOND REPO NAME>")
			expect(page).not_to have_link("<THIRD REPO NAME>")
			expect(page).not_to have_link("<FOURTH REPO NAME>")
			expect(page).not_to have_link("<FITH REPO NAME>")
			expect(page).not_to have_link("<FIRST REPO NAME>")

			# this should be the list of repos for admin2 that was defined at the top of this test.
			expect(page).to have_link("<FIRST REPO NAME>")
			expect(page).to have_link("<SECOND REPO NAME>")
			expect(page).to have_link("<THIRD REPO NAME>")
			expect(page).to have_link("<FOURTH REPO NAME>")
			expect(page).to have_link("<FITH REPO NAME>")
		end

		it 'I Do not see any GIT HUB repositories if I do not have a github token' do
			admin3 = create(:admin)

			click_on "Log Out"

			expect(current_path).to eq("/")

			click_on "Sign In"

			expect(current_path).to eq("/login")

			fill_in 'session[email]', with: admin3.email
			fill_in 'session[password]', with: admin3.password

			click_on 'Log In'

			expect(current_path).to eq(dashboard_path)

			expect(page).to have_content("Log into Github")
		end
	end
end
