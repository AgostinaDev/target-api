module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token, only: :create

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render json: { user: resource_data }
      end
    end
  end
end
