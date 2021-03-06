require 'rails_helper'

RSpec.describe 'As a Admin' do
	describe 'When I visit a Tutorial show page' do
	  it "I can delete a tutorial" do
	    admin = create(:admin)
	    create_list(:tutorial, 2)

	    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

	    visit "/admin/dashboard"

	    expect(page).to have_css('.admin-tutorial-card', count: 2)

	    within(first('.admin-tutorial-card')) do
	      click_link 'Delete'
	    end

	    expect(page).to have_css('.admin-tutorial-card', count: 1)
	  end
	end
end
