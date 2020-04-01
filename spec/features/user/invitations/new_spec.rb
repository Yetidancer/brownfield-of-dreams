require 'rails_helper'

describe 'As a registered user' do
  describe 'when I visit my dashboard' do
    describe 'I should see a section to invite users from GitHub.' do
      before :each do
        user = create(:user, token: ENV['TEST_KEY'])
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit dashboard_path

        click_button 'Send an Invite'

        expect(current_path).to eq(invite_new_path)
      end

      it 'I can invite a user that has an email address associated with their github account', :vcr do
        fill_in 'github_handle', with: 'sasloan'

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content('Successfully sent invite!')
      end

      it 'I get a notification if the user doesnt have an email address associated with their account', :vcr do
        fill_in 'github_handle', with: 'FakerMcFakerson'

        click_button 'Send Invite'

        expect(current_path).to eq(dashboard_path)

        expect(page).to have_content('The Github user you selected does not have an email address associated with their account.')
      end
    end
  end
end
