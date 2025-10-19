# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def me
    render json: Current.user, serializer: UserSerializer
  end
end
