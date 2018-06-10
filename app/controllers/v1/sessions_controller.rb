module V1
  class SessionsController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def login
      @user = User.find_for_database_authentication(email: params[:email])
      return invalid_login_attempt unless @user

      if @user.valid_password?(params[:password])
        sign_in :user, @user
        render json: @user, serializer: SessionSerializer, root: nil
      else
        invalid_login_attempt
      end
    end

    def sign_up
      @user = create_new_user
      @user.save
      render json: { access_token: @user.access_token }
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: { error: 'Invalid Login Attempt' }, status: :unprocessable_entity
    end

    def create_new_user
      User.new(email: params[:email], password: params[:password], password_confirmation: params[:password], name: params[:name], work_field: params[:work_field], job_title: params[:job_title], work_place: params[:work_place])
    end
  end
end