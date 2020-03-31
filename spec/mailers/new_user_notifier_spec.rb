require "rails_helper"

RSpec.describe NewUserNotifierMailer, type: :mailer do
  describe "New User Noftifier" do
	 	let(:mail) {NewUserNotifierMailer.mail}

		it 'renders the headers' do
			expect(mail.subject).to eq("Activate your new account.")
			expect(mail.to).to eq(["to@example.org"])
		end

		it "renders the body" do
			expect(mail.body.encoded).to match("This email has been sent to you so that you can activate your new
			Brown Field of Dreams account. please click the link below to activate your
			account.")
		end
	end
end
