require "rails_helper"

RSpec.describe InvitationNotifierMailer, type: :mailer do
	describe 'inform' do
		before :each do
			@recipient = create(:user, token: ENV['TEST_KEY'])
		end

		let(:mail) { described_class.inform(@recipient).deliver_now }

		it 'renders the subject' do
			expect(mail.subject).to eq("#{@recipient.sender_name} is inviting you to join Brownfield of Dreams.")
		end

		it 'renders the receiver email' do
			expect(mail.to).to eq([@recipient.email])
		end

		it 'renders the sender email' do
			expect(mail.from).to eq(['admin@brownfieldofdreams.com'])
		end
	end
end
