require 'rails_helper'

feature 'user can see their repos' do

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

    user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: ENV["YET_GITHUB_TOKEN"])
    user2 = create(:user, email: "person1@example.com", first_name: "Cheesey", last_name: "Geckoy", password: "password1", token: ENV["SAS_GITHUB_TOKEN"])

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

feature 'As a user that has not logged into Gihhub yet' do
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

		visit '/'

		click_on "Sign In"

		expect(current_path).to eq(login_path)

		fill_in 'session[email]', with: user.email
		fill_in 'session[password]', with: user.password

		click_on 'Log In'

		expect(current_path).to eq(dashboard_path)


		visit '/dashboard'

    click_on "Connect to Github"

		expect(page).to have_content("Github")
		expect(page).to have_css(".follower")
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
		expect(page).to have_css(".following")
		expect(page).to have_link("tayjames")
	end
end
end
