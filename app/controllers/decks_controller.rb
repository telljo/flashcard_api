# app/controllers/decks_controller.rb
class DecksController < ApplicationController
  before_action :set_deck, only: %i[show update destroy]

  def index
    decks = Current.user.decks
    render json: decks
  end

  def show
    render json: @deck
  end

  def destroy
    if @deck.destroy
      head :no_content
    else
      render_error(messages: @deck.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = Current.user

    if @deck.save!
      render json: @deck
    else
      render_error(messages: @deck.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def update
    if @deck.update(deck_params)
      render json: @deck
    else
      render_error(messages: @deck.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def set_deck
    @deck = Deck.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def deck_params
    params.require(:deck).permit(
      :name, :description
    )
  end
end
