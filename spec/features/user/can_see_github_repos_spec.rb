require 'rails_helper'

feature 'user can see their repos' do

  scenario 'user logs in and visits dashboard' do
    visit '/dashboard'

    expect(page).to have_content("Github")
    expect(page).to have_css(".repo", count:5)

    within(first(".repo")) do
      #expect(page).to have_link to the repo
    end
  end

end
