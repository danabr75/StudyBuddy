class CardsController < ResourcesController
  def new
    @deck = Deck.accessible_by(current_ability).find(params[:deck_id])
    @card = @deck.cards.new
    @card.assign_attributes(card_params) if params[:card].present?

    # Won't work for alias or custom association names
    # Only works if the association is also a custom action on the ability object
    if params[:account_id].present? && @resource_class.column_names.include?('account_id')
      # authorize! @resource_class.name.pluralize.underscore.to_sym, Account.friendly.find(params[:account_id])
      @filters['account_id'] = Account.friendly.find(params[:account_id]).id
    end
    begin
      @resources ||= @resource_class
      @resources = @resources.accessible_by(current_ability)
      update_debug_api("#{@resource_class.name}.accessible_by(User.find(#{current_user.id}).ability)")
    rescue CanCan::Error
      # The accessible_by call cannot be used with a block 'can' definition
      # Need to switch over to SQL permissions, not using the blocks
      Rails.logger.info "Warning: resource class, #{@resource_class.name}, is using CanCan block definitions, not SQL permissions. Unable to run index permission filter"
      @resources = @resource_class
    end

  end

  def create
    @deck = Deck.accessible_by(current_ability).find(params[:deck_id])
    @card = @deck.cards.create(card_params)
    redirect_to deck_path(@deck)
  end

  def edit
    @deck = Deck.accessible_by(current_ability).find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
  end

  def update
    @deck = Deck.accessible_by(current_ability).find(params[:deck_id])
    @card = @deck.cards.find(params[:id])

    if @card.update(card_params)
      redirect_to deck_path(@deck)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @deck = Deck.accessible_by(current_ability).find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
    @card.destroy
    redirect_to deck_path(@deck), status: :see_other
  end

  def guess
    @card = Card.accessible_by(current_ability).find(params[:card_id])
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
