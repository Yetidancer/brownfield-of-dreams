require 'rails_helper'

RSpec.describe EmailInvitation do
  it 'has attributes' do
		sender_name = "Jack Black"
    user_params = {
      name: 'Joseph Joestar',
      email: 'email@example.com'
    }

    user = EmailInvitation.new(sender_name, user_params)

    expect(user.sender_name).to eq(sender_name)
    expect(user.name).to eq(user_params[:name])
    expect(user.email).to eq(user_params[:email])
  end
end
