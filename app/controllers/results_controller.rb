class ResultsController < ResourcesController
  before_action :authenticate_user!, except: %w[new create]

  def create
    @deck = Deck.find(params[:deck_id])
    if current_user.nil?
      @result = @deck.results.new(result_params)
      msg = t('deck.results_for_non_registered_users', percent_correct: @result.to_h)
      redirect_to deck_path(@deck), alert: msg and return
    end

    @result = @deck.results.new(result_params)
    @result.user_id = current_user.id
    @result.save!
    redirect_to deck_path(@deck)
  end

  def new
    @deck = Deck.find(params[:deck_id])
    if @deck.cards.none?
      redirect_to deck_path(@deck), alert: "No cards within deck to study!" and return
    end
    @cards = @deck.cards.order("RANDOM()")
  end

  def update
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.find(params[:id])

    if @result.update(result_params)
      redirect_to deck_path(@deck)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.find(params[:id])
    @result.destroy
    redirect_to deck_path(@deck), status: :see_other
  end

  private

  def result_params
    params.require(:result).permit(:deck_id, card_results_attributes: %i[card_id correct])
  end
end
