class Result < ApplicationRecord
  belongs_to :deck
  has_many :card_results, dependent: :destroy

  # has_many :card_results
end
