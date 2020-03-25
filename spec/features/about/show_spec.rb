require 'rails_helper'

RSpec.describe 'As a Visitor' do
	describe 'When I visit the about show page' do
		it 'I can see the tutorials ' do

			visit '/about'

			expect(page).to have_content("Turing Tutorials")
		end
	end
end
