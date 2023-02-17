class CardResult < ApplicationRecord
  belongs_to :result, inverse_of: :card_results
  belongs_to :card
end
