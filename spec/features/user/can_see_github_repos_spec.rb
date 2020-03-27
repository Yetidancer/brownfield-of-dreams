require 'rails_helper'

feature 'user can see their repos' do

  it 'user logs in and visits dashboard', :vcr do
    user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: "3ee7561ad7909cb0da148d6a29e89b05e8f2952a")

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
    user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: "8fcd32841e5a71543e7ab0515e83c4528e6da8f8")
    user2 = create(:user, email: "person1@example.com", first_name: "Cheesey", last_name: "Geckoy", password: "password1", token: "17247f81c2c38c6ea384d2a8d078103943340471")

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

	it 'User logs into their Dashboard and can see followers', :vcr do
		user = create(:user, email: "person@example.com", first_name: "Cheese", last_name: "Gecko", password: "password", token: "e52edaa49e5c6803db5fe206886d00be0a86ac00")

		visit '/'

		click_on "Sign In"

		expect(current_path).to eq(login_path)

		fill_in 'session[email]', with: user.email
		fill_in 'session[password]', with: user.password

		click_on 'Log In'

		expect(current_path).to eq(dashboard_path)

		visit '/dashboard'

		expect(page).to have_content("Github")
		expect(page).to have_css(".follower")
		expect(page).to have_link("sasloan")
	end
end
