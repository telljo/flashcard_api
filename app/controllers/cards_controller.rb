# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  before_action :set_deck
  before_action :set_card, only: %i[show update destroy]

  def index
    cards = @deck.cards
    render json: cards
  end

  def show
    render json: @card
  end

  def destroy
    if @card.destroy
      head :no_content
    else
      render_error(messages: @card.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def create
    @card = @deck.cards.new(card_params)

    if @card.save!
      render json: @card
    else
      render_error(messages: @card.errors.full_messages, status: :unprocessable_entity)
    end
  end

  def update
    if @card.update(card_params)
      render json: @card
    else
      render_error(messages: @card.errors.full_messages, status: :unprocessable_entity)
    end
  end

  private

  def set_card
    @card = Card.find(params.expect(:id))
  end

  def set_deck
    @deck = Deck.find(params.expect(:deck_id))
  end

  # Only allow a list of trusted parameters through.
  def card_params
    params.require(:card).permit(
      :front, :back, :hint
    )
  end
end
