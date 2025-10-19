class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ create ]

  def create
    user = User.new(user_params)
    if user.save
      token = JsonWebToken.encode({ user_id: user.id }, 24.hours.from_now)
      render json: { token: token, user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email_address, :password, :password_confirmation)
  end
end
