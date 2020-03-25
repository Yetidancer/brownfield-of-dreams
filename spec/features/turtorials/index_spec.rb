require 'rails_helper'

RSpec.describe 'As a Visitor' do
	describe 'When I visit the tutorials index page' do
		it 'I see a list of turtorials to choose from' do
			create_list(:tutorial, 3)

			visit '/tutorials'

			expect(page).to have_content(Turtorial.first)
			expect(page).to have_content(Turtorial.last)
		end
	end
end
