class ResultsController < ResourcesController
  # - Mimic updating Card in db -
  def create
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.create(result_params)
    redirect_to deck_path(@deck)
  end

  # - Display from Studys Ex - Not updating db -
  def new
    @deck = Deck.find(params[:deck_id])
    if @deck.cards.count == 0
      redirect_to deck_path(@deck), alert: "No cards within deck to study!" and return
    end
    @cards = @deck.cards.order("RANDOM()")
    # @result = @deck.results.find(params[:id])
  end

  def update
    # - Mimic cards update -
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.find(params[:id])

    if @result.update(result_params)
      redirect_to deck_path(@deck)
    else
      render :edit, status: :unprocessable_entity
    end

    # # - Mimic decks update -
    # @deck = Deck.find(params[:id])

    # if @deck.update(deck_params)
    #   redirect_to @deck
    # else
    #   render :edit, status: :unprocessable_entity
    # end
  end

  # def index
  # end

  def destroy
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.find(params[:id])
    @result.destroy
    redirect_to deck_path(@deck), status: :see_other
  end

  # TODO: - Fix
  private

  def result_params
    # params.require(:person).permit(:name, :age, pets_attributes: [ :id, :name, :category ])
    params.require(:result).permit(:deck_id, card_results_attributes: %i[card_id correct])
  end
end
