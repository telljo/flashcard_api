module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      Current.user.present?
    end

    def require_authentication
      authenticate_with_jwt || render_unauthorized
    end

    def authenticate_with_jwt
      token = extract_token_from_header
      return unless token

      decoded = JsonWebToken.decode(token)
      return unless decoded && decoded[:user_id]

      user = User.find_by(id: decoded[:user_id])
      Current.user = user if user
    end

    def extract_token_from_header
      auth_header = request.headers['Authorization']
      return nil unless auth_header && auth_header.start_with?('Bearer ')
      auth_header.split(' ').last
    end

    def render_unauthorized
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
end
