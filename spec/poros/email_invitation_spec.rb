require 'rails_helper'

RSpec.describe EmailInvitation do
  it 'has attributes' do
		sender_name = "Jack Black"
    user = GithubUser.new(name: 'Joseph Joestar',
      email: 'email@example.com')

    user = EmailInvitation.new(sender_name, user)

    expect(user.sender).to eq(sender_name)
    expect(user.recipient).to eq(user.name)
    expect(user.email).to eq(user.email)
  end
end
