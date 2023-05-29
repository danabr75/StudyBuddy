class DecksController < ResourcesController
  respond_to :html, :turbo_stream

  # def index
  #   @decks = Deck.accessible_by(current_ability)
  #   puts "#{@decks.class}"
  #   @decks = @decks.search(params[:search]) if params.key?(:search)
  #   # @decks = @decks.search(params[:search]) if params[:search].present?
  #   @decks = @decks.paginate(page: params[:page], per_page: 30)
  #   respond_to do |format|
  #     format.turbo_stream do
  #       render turbo_stream: turbo_stream.replace('decks', partial: "decks/deck", collection: @decks)
  #     end
  #     format.html { render :index }
  #   end
  # end


  def index
    @decks = Deck.accessible_by(current_ability)
    puts "#{@decks.class}"
    @decks = @decks.search(params[:search]) if params.key?(:search)
    # @decks = @decks.search(params[:search]) if params[:search].present?
    @decks = @decks.paginate(page: params[:page], per_page: 30)
    respond_to do |format|
      format.html {puts('HTML render')}
      format.turbo_stream {puts "TURBO RENDER"}
    end
  end

  def show
    @deck = Deck.find(params[:id])
    @cards = @deck.cards.search(params[:card_search])
    @cards = @cards.paginate(page: params[:page], per_page: 3)
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
