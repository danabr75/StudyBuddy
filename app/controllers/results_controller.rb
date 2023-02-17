class ResultsController < ApplicationController

# - Mimic updating Card in db -
  def create
    puts "HereIAm"
    puts params.inspect
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.create(result_params)
    redirect_to deck_path(@deck)
  end

  # - Display from Studys Ex - Not updating db -
  def edit
    @deck = Deck.find(params[:deck_id])
    @result = @deck.results.find(params[:id])
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

  # TODO - Fix
  private
    def result_params
      params.require(:result).permit(:correct)
    end
end
