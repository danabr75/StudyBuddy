class DecksController < ApplicationController
  def index
    @decks = Deck.paginate(page: params[:page], per_page: 30)
  end

  def show
    @deck = Deck.find(params[:id])
    # Search does work, but doesn't specify the deck...
    @cards = @deck.cards.search(params[:search])
    # @cards = @deck.cards.paginate(page: params[:page], per_page: 3)
    @results = @deck.results
    # @previous_results = @deck.results.where(user_id: @current_user&.id)
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)

    if @deck.save
      redirect_to @deck
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])

    if @deck.update(deck_params)
      redirect_to @deck
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end
