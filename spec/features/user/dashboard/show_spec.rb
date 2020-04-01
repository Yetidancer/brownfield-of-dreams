require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I log in I am sent to my dashboard', :vcr do
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

	describe 'user can see their repos' do

	  it 'user logs in and visits dashboard', :vcr do
	    user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: ENV["YET_GITHUB_TOKEN"])

	    visit '/'

	    click_on "Sign In"

	    expect(current_path).to eq(login_path)

	    fill_in 'session[email]', with: user.email
	    fill_in 'session[password]', with: user.password

	    click_on 'Log In'

	    expect(current_path).to eq(dashboard_path)

	    visit '/dashboard'

	    expect(page).to have_content("Github")
	    expect(page).to have_css(".repo", count:5)

	    within(first(".repo")) do
	      expect(page).to have_link("monster_shop_1911")
	    end

	    expect(page).to have_link("D_and_Z_Pet_Place")
	  end

	  it 'user logs in and visits dashboard and does not see the previous log ins repos', :vcr do

	    user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: ENV["YET_GITHUB_TOKEN"], github_username: "Yetidancer")
	    user2 = create(:user, email: "person1@example.com", first_name: "Cheesey", last_name: "Geckoy", password: "password1", token: ENV["SAS_GITHUB_TOKEN"], github_username: "sasloan")

	    visit '/'

	    click_on "Sign In"

	    expect(current_path).to eq(login_path)

	    fill_in 'session[email]', with: user.email
	    fill_in 'session[password]', with: user.password

	    click_on 'Log In'

	    expect(current_path).to eq(dashboard_path)

	    visit '/dashboard'

	    expect(page).to have_content("Github")
	    expect(page).to have_css(".repo", count:5)

	    within(first(".repo")) do
	      expect(page).to have_link("monster_shop_1911")
	    end

			click_on "Log Out"

			visit '/'

			expect(current_path).to eq('/')

			click_on "Sign In"

	    expect(current_path).to eq(login_path)

	    fill_in 'session[email]', with: user2.email
	    fill_in 'session[password]', with: user2.password

	    click_on 'Log In'

	    expect(current_path).to eq(dashboard_path)

	    visit '/dashboard'

	    expect(page).to have_content("Github")
	    expect(page).to have_css(".repo", count:5)
	    expect(page).to_not have_link("D_and_Z_Pet_Place")
	  end

	  describe 'As a user that has not logged into Github yet' do
	  	before :each do
	  		OmniAuth.config.mock_auth[:github] = nil
	  		OmniAuth.config.test_mode = true
	  		OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
	  			{"provider" => "github",
	  			 "info" => {"name" => "Sebastian Sloan"},
	  			 "credentials" =>
	  			 		{"token" => ENV["TEST_KEY"],
	  					 "expires" => false},
	  			 "extra"=>
	  			 		{"raw_info" =>
	  							{"login" => "sasloan",
	  							 "html_url" => "https://github.com/sasloan",
	  							 "name" => "Sebastian Sloan"
	  				}}})
	  	end

	  	it 'If a user does not have a github token then they can set one up in the dashboard', :vcr do
	  		user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password")
	  		user = create(:user, email: "people@example.com", first_name: "Queso", last_name: "Lizard", password: "password", github_username: "meghanstovall")
	  		user = create(:user, email: "poople@example.com", first_name: "Fromage", last_name: "Dragon", password: "password", github_username: "kathleen-carroll")
	  		user = create(:user, email: "purple@example.com", first_name: "Brie", last_name: "Salamander", password: "password", github_username: "sasloan")

	  		visit '/'

	  		click_on "Sign In"

	  		expect(current_path).to eq(login_path)

	  		fill_in 'session[email]', with: user.email
	  		fill_in 'session[password]', with: user.password

	  		click_on 'Log In'

	  		expect(current_path).to eq(dashboard_path)

	  		visit '/dashboard'

	      click_on "Connect to Github"

	      user.reload

	  		expect(page).to have_content("Github")
	  		expect(page).to have_css("#follower-sasloan")
	  		expect(page).to have_link("sasloan")
	  	end

	  	it 'User logs into their Dashboard and can see the other users it is following', :vcr do
	  		user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: ENV["YET_GITHUB_TOKEN"])

	  		visit '/'

	  		click_on "Sign In"

	  		expect(current_path).to eq(login_path)

	  		fill_in 'session[email]', with: user.email
	  		fill_in 'session[password]', with: user.password

	  		click_on 'Log In'

	  		expect(current_path).to eq(dashboard_path)

	  		visit '/dashboard'

	  		expect(page).to have_content("Github")
	  		expect(page).to have_css("#following-tayjames")
	  		expect(page).to have_link("tayjames")
	  	end
	  end

		describe 'When I am logged in, I' do
		  it 'can add videos to their bookmarks' do
		    tutorial= create(:tutorial, title: "How to Tie Your Shoes")
		    video = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial)
		    user = create(:user)

		    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		    visit tutorial_path(tutorial)

		    expect {
		      click_on 'Bookmark'
		    }.to change { UserVideo.count }.by(1)

		    expect(page).to have_content("Bookmark added to your dashboard")
		  end

		  it "can't add the same bookmark more than once" do
		    tutorial= create(:tutorial)
		    video = create(:video, tutorial_id: tutorial.id)
		    user = create(:user)

		    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

		    visit tutorial_path(tutorial)

		    click_on 'Bookmark'
		    expect(page).to have_content("Bookmark added to your dashboard")
		    click_on 'Bookmark'
		    expect(page).to have_content("Already in your bookmarks")
		  end
		end

		describe 'When I log into my dashboard, and am connected to github', :vcr do
			it 'I can see my followers and people I am following and add them to my friends list' do

				user1 = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: ENV["YET_GITHUB_TOKEN"], github_username: "Yetidancer")
				user2 = create(:user, email: "person1@example.com", first_name: "Cheesey", last_name: "Geckoy", password: "password1", token: ENV["SAS_GITHUB_TOKEN"], github_username: "sasloan")

				visit '/'

				click_on "Sign In"

				expect(current_path).to eq(login_path)

				fill_in 'session[email]', with: user1.email
				fill_in 'session[password]', with: user1.password

				click_on 'Log In'

				expect(current_path).to eq(dashboard_path)

				within"#follower-#{user2.github_username}" do
		      expect(page).to have_button("Add as Friend")
					click_on "Add as Friend"
		    end

				expect(current_path).to eq(dashboard_path)

				within "#friend-#{user2.id}" do
					expect(page).to have_content("Cheesey")
				end
			end
		end
	end
end
