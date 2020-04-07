# frozen_string_literal: true

class Api
  class V1
    # This is a class
    class VideosController < ApplicationController
      def show
        render json: Video.find(params[:id])
      end
    end
  end
end
