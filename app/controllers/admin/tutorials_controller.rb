# frozen_string_literal: true

# This is a class
class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
		tutorial = Tutorial.new(tutorial_params)

		if tutorial.save
			redirect_to "/tutorials/#{tutorial.id}"
			flash[:success] = "Successfully created tutorial."
		else
			redirect_to "/admin/tutorials/new"
			flash[:notice] = tutorial.errors.full_messages.to_sentence
		end
  end

  def new
  	@tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
		redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    if tutorial.destroy
      flash[:success] = "#{tutorial.title} tagged!"
    end
		redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

	def new_tutorial_params
		params[:tutorial].permit(:title, :description, :thumbnail)
	end
end
