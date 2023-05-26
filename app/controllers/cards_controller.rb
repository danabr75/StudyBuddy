class CardsController < ApplicationController
  def new
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.new
    @card.assign_attributes(card_params) if params[:card].present?
  end

  def create
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.create(card_params)
    redirect_to deck_path(@deck)
  end

  def edit
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])

    if @card.update(card_params)
      redirect_to deck_path(@deck)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
    @card.destroy
    redirect_to deck_path(@deck), status: :see_other
  end

  def guess
    @card = Card.find(params[:card_id])
    guess = params[:guess]
    guess_result = false
    if guess&.strip&.downcase == @card.blank&.strip&.downcase
      guess_result = true
    end

    render json: { success: guess_result }
  end

  private

  def card_params
    params.require(:card).permit(:header, :lines, :blank, :search_cards)
  end
end
