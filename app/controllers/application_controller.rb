class ApplicationController < ActionController::API
  include Authentication

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :handle_unprocessable_entity
  rescue_from JWT::DecodeError, with: :handle_unauthorized
  rescue_from JWT::ExpiredSignature, with: :handle_token_expired

  private

  def handle_not_found(exception)
    render_error(messages: [exception.message], status: :not_found)
  end

  def handle_unprocessable_entity(exception)
    render_error(messages: exception.record.errors.full_messages, status: :unprocessable_entity)
  end

  def handle_unauthorized
    render_error(messages: ['Invalid or missing token'], status: :unauthorized)
  end

  def handle_token_expired
    render_error(messages: ['Token has expired'], status: :unauthorized)
  end

  def render_error(messages:, status:)
    render json: {
      success: false,
      error: {
        message: messages,
        status: Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      }
    }, status: status
  end
end
