class Result < ApplicationRecord
  belongs_to :deck
  has_many :card_results, inverse_of: :result, dependent: :destroy
  accepts_nested_attributes_for :card_results

  # has_many :card_results
end
