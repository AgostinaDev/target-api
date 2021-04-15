module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def create
        @target = current_user.targets.create!(create_params)
        render_error_response if @target.new_record?
      end

      private

      def create_params
        params.require(:target).permit(:title, :radius, :latitude, :longitude, :topic_id)
      end

      def render_error_response
        render json: { errors: @target.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
