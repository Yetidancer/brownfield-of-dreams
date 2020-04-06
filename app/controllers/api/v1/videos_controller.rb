# frozen_string_literal: true

# This is a class
class Api
  class V1
    class VideosController < ApplicationController
      def show
        render json: Video.find(params[:id])
      end
    end
  end
end
