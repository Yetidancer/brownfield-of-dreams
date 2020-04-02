require "rails_helper"

RSpec.describe InvitationNotifierMailer, type: :mailer do
	describe 'inform' do
		before :each do
			@invitee = GithubUser.new(name: "James Bond", username: "sasloan", profile_url: "example.com", email: "bond@example.com")
	    @invitation = EmailInvitation.new("Joe Sender", @invitee)
		end

		let(:mail) { described_class.inform(@invitation).deliver_now }

		it 'renders the subject' do
			expect(mail.subject).to eq("#{@invitation.sender} is inviting you to join Brownfield of Dreams.")
		end

		it 'renders the receiver email' do
			expect(mail.to).to eq([@invitation.email])
		end

		it 'renders the sender email' do
			expect(mail.from).to eq(['admin@brownfieldofdreams.com'])
		end
	end
end
