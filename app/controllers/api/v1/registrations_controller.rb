module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token, only: :create

      private

      def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :gender, :email, :password,
                                     :password_confirmation)
      end

      def render_create_success
        render json: { user: resource_data }
      end
    end
  end
end
