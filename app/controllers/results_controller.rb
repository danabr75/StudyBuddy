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
  def new
    @deck = Deck.find(params[:deck_id])
    #@result = @deck.results.find(params[:id])
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
      #params.require(:person).permit(:name, :age, pets_attributes: [ :id, :name, :category ])

      #  Parameters: {"authenticity_token"=>"[FILTERED]", "result"=>{"card_results_attributes"=>{"0"=>{"correct"=>"1", "card_id"=>"1"}, "1"=>{"correct"=>"0", "card_id"=>"2"}, "2"=>{"correct"=>"0", "card_id"=>"3"}, "3"=>{"correct"=>"0", "card_id"=>"7"}, "4"=>{"correct"=>"1", "card_id"=>"8"}, "5"=>{"correct"=>"1", "card_id"=>"9"}, "6"=>{"correct"=>"0", "card_id"=>"10"}}}, "commit"=>"Create Result", "deck_id"=>"1"}
      params.require(:result).permit(:deck_id, card_results_attributes: [:card_id, :correct])
    end
end
