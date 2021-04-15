module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      protect_from_forgery with: :null_session
      before_action :authenticate_user!
    end
  end
end
