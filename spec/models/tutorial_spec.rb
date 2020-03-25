require 'rails_helper'

RSpec.describe Tutorial, type: :model do
	describe 'Validations' do
		it {should validate_presence_of :title}
		it {should validate_presence_of :description}
	end

	describe 'Relationships' do
		it {should have_many :videos}
	end
end
