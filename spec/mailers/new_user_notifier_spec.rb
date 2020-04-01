require "rails_helper"

RSpec.describe NewUserNotifierMailer, type: :mailer do
	describe 'inform' do
		before :each do
			@user = create(:user, token: ENV['TEST_KEY'])
			@email_info = {user: @user, message: "Hello World"}
		end

		let(:mail) { described_class.inform(@email_info, @user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq("#{@email_info[:user].first_name}, Please Authenticate your account.")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([@email_info[:user].email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['admin@brownfieldofdreams.com'])
    end
  end
end
