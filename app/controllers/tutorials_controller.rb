class TutorialsController < ApplicationController

	def index
		@tutorials = Tutorial.all
	end

  def show
    # require "pry"; binding.pry
		@tutorial = Tutorial.find(params[:id])
		@facade = TutorialFacade.new(@tutorial, params[:video_id])
  end
end
