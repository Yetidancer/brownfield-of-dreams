require 'rails_helper'

RSpec.describe 'As a Visitor' do
	describe 'When I visit a videos show page' do
	  it 'clicks on the bookmark page and is sent to the log in page' do
	    tutorial = create(:tutorial)
	    video = create(:video, tutorial_id: tutorial.id)

	    visit tutorial_path(tutorial)

	    click_on 'Bookmark'

	    expect(current_path).to eq(login_path)
		end

		it 'vistor clicks on a tutorial title from the home page' do
			tutorial = create(:tutorial)
			video = create(:video, tutorial_id: tutorial.id)

			visit '/'

			click_on tutorial.title

			expect(current_path).to eq(tutorial_path(tutorial))
			expect(page).to have_content(video.title)
			expect(page).to have_content(tutorial.title)
		end
	end
end
