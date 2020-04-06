# frozen_string_literal: true

# This is a class
class VideosController < ApplicationController
	def show
		@video = Video.find(params[:id])
	end
end
