class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def create
    user = User.find_by(email_address: params[:email_address])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode({ user_id: user.id }, 24.hours.from_now)

      render json: {
        token: token,
        user: UserSerializer.new(user)
      }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    # JWT is stateless — you can't really "logout" on the server
    # Client just discards the token.
    head :no_content
  end
end
