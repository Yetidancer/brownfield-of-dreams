require 'rails_helper'

RSpec.describe 'As a Admin' do
	describe "I can visit the admin dashboard" do
	  it "can see all tutorials" do
	    admin = create(:admin)
	    create_list(:tutorial, 2)

	    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

	    visit "/admin/dashboard"

	    expect(page).to have_css(".admin-tutorial-card", count: 2)
	  end
	end
end
