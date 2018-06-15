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

    def update_user
      user = current_user
      user.name = params[:name] if params[:name]
      user.job_title = params[:job_title] if params[:job_title]
      if params[:interest]
        user.interests.create(interest: params[:interest])
        render json: user.interests
      end
      user.gender_preference = params[:gender_preference]
      user.save
    end

    def fetch_matches
      user = current_user
      user.latitude = params[:latitude].to_f
      user.longitude = params[:longitude].to_f
      user.save
      @users = User.near([params[:latitude], params[:longitude]], 50)
      users = []
      @users.each do |user|
        next if user.id == current_user.id
        users << { user: user, interests: user.interests } unless (current_user.interests.collect(&:interest) & user.interests.collect(&:interest)).empty?
      end
      render json: users
    end

    def return_images
      user = current_user
      render json: user.images
    end

    def uploads
      user = current_user
      user.images.create(base_64: params[:base64_image_data])
      user.save
    end

    private

    def invalid_login_attempt
      warden.custom_failure!
      render json: { error: 'Invalid Login Attempt' }, status: :unprocessable_entity
    end

      def current_user
        User.where(access_token: params[:access_token]).first
      end

    def create_new_user
      User.new(email: params[:email], password: params[:password], password_confirmation: params[:password])
    end
  end
end