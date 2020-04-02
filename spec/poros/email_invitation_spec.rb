require 'rails_helper'

RSpec.describe EmailInvitation do
  it 'has attributes' do
		sender_name = "Jack Black"
    user = GithubUser.new(name: 'Joseph Joestar',
      email: 'email@example.com')

    invitation = EmailInvitation.new(sender_name, user)

    expect(invitation.sender).to eq(sender_name)
    expect(invitation.recipient).to eq(user.name)
    expect(invitation.email).to eq(user.email)
  end
end
