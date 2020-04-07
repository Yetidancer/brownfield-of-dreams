# frozen_string_literal: true

# This is a class
class Api
  class V1
    class TutorialsController < ApplicationController
      def index
        render json: Tutorial.all
      end

      def show
        tutorial = Tutorial.find(params[:id])
        if (tutorial.classroom == true && current_user) ||
        (tutorial.classroom == false)
          render json: tutorial
        else
          flash[:error] = 'You must log in to view this tutorial.'
        end
      end
    end
  end
end
