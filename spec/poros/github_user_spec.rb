require 'rails_helper'

RSpec.describe GithubUser do
  it 'has attributes' do
    user_params = {
      login: 'username',
      html_url: 'https://github.com/CoopTang',
      email: 'email@example.com'
    }

    user = GithubUser.new(user_params)

    expect(user.username).to eq(user_params[:login])
    expect(user.profile_url).to eq(user_params[:html_url])
    expect(user.email).to eq(user_params[:email])
  end
end
