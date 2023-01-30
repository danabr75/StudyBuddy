class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_results, dependent: :destroy
end
