require 'rails_helper'

RSpec.describe 'As a User' do
  it 'I user can sign in', :vcr do
    user = create(:user)

    visit '/'

    click_on "Sign In"

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content(user.email)
    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name)
  end

  it 'I can log out', :js, :vcr do
    user = create(:user)

    visit login_path

    fill_in'session[email]', with: user.email
    fill_in'session[password]', with: user.password

    click_on 'Log In'

    click_on 'Profile'

    expect(current_path).to eq(dashboard_path)

    click_on 'Log Out'

    expect(current_path).to eq(root_path)
    expect(page).to_not have_content(user.first_name)
    expect(page).to have_content('SIGN IN')
  end

  it 'I am shown an error when incorrect info is entered', :vcr do
    user = create(:user)
    fake_email = "email@email.com"
    fake_password = "123"

    visit login_path

    fill_in'session[email]', with: fake_email
    fill_in'session[password]', with: fake_password

    click_on 'Log In'

    expect(page).to have_content("Looks like your email or password is invalid")
  end


	it 'I can not make two users with the same log in' do
		user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

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
