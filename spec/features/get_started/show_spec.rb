require 'rails_helper'

RSpec.describe 'As a User' do
	describe 'When I get started' do
		it 'I am sent to the get started show page' do

			visit '/get_started'

			expect(page).to have_content("Get Started")
		end
	end
end
