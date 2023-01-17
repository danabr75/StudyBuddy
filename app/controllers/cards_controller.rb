class CardsController < ApplicationController
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

  private
    def card_params
      params.require(:card).permit(:header, :lines, :blank)
    end
end
