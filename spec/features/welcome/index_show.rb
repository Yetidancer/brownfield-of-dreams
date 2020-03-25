require 'rails_helper'

RSpec.describe 'As a Visitor' do
  describe 'When I visit the home page' do
    it 'I can see a list of tutorials' do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      video1 = create(:video, tutorial_id: tutorial1.id)
      video2 = create(:video, tutorial_id: tutorial1.id)
      video3 = create(:video, tutorial_id: tutorial2.id)
      video4 = create(:video, tutorial_id: tutorial2.id)

      visit root_path

      expect(page).to have_css('.tutorial', count: 2)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
      end
    end

		it 'I can create a sign in' do
		email = 'jimbob@aol.com'
		first_name = 'Jim'
		last_name = 'Bob'
		password = 'password'
		password_confirmation = 'password'

		visit '/'

		click_on 'Sign In'

		expect(current_path).to eq(login_path)

		click_on 'Sign up now.'

		expect(current_path).to eq(new_user_path)

		fill_in 'user[email]', with: email
		fill_in 'user[first_name]', with: first_name
		fill_in 'user[last_name]', with: last_name
		fill_in 'user[password]', with: password
		fill_in 'user[password_confirmation]', with: password

		click_on'Create Account'

		expect(current_path).to eq(dashboard_path)

		expect(page).to have_content(email)
		expect(page).to have_content(first_name)
		expect(page).to have_content(last_name)
		expect(page).to_not have_content('Sign In')
		end
  end

	describe 'When I visit a videos show page' do
		it 'clicks on the bookmark page and is sent to the log in page' do
			tutorial = create(:tutorial)
			video = create(:video, tutorial_id: tutorial.id)

			visit tutorial_path(tutorial)

			click_on 'Bookmark'

			expect(current_path).to eq(login_path)
		end

		it 'vistor clicks on a tutorial title from the home page' do
			tutorial = create(:tutorial)
			video = create(:video, tutorial_id: tutorial.id)

			visit '/'

			click_on tutorial.title

			expect(current_path).to eq(tutorial_path(tutorial))
			expect(page).to have_content(video.title)
			expect(page).to have_content(tutorial.title)
		end
	end
end
