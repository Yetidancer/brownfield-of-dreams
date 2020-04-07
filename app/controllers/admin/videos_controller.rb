# frozen_string_literal: true

class Admin
  # This is a class
  class VideosController < Admin::BaseController
    def edit
      @video = Video.find(params[:id])
    end

    def update
      video = Video.find(params[:id])
      video.update(video_params)
      tutorial = video.tutorial

      if video.save
        flash[:success] = 'Your Video has been updated!'
        redirect_to "/admin/tutorials/#{tutorial.id}/edit"
      else
        flash[:error] = 'Invalid information entered try again'
        redirect_to "/admin/videos/#{video.id}/edit"
      end
    end

    ###
    def create
      tutorial = Tutorial.find(params[:tutorial_id])
      thumbnail = YouTube::Video.by_id(new_video_params[:video_id]).thumbnail
      video = tutorial.videos.new(new_video_params.merge(thumbnail: thumbnail))

      if video.save
        flash[:success] = 'Successfully created video.'
      else
        flash[:error] = 'Unable to create video.'
      end

      redirect_to edit_admin_tutorial_path(id: tutorial.id)
    end

    private

    def video_params
      params.permit(:title, :decribe)
    end

    def new_video_params
      params.require(:video).permit(:title, :description, :video_id, :thumbnail)
    end
  end
end
