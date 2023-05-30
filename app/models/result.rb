class Result < ApplicationRecord
  belongs_to :deck
  has_many :card_results, inverse_of: :result, dependent: :destroy
  belongs_to :user
  scope :oldest_to_newest, -> { order(created_at: :desc) }
  scope :created_at_asc, -> { order(created_at: :asc) }
  scope :last_8, -> { oldest_to_newest.limit(8)}
  accepts_nested_attributes_for :card_results

  # Returns the overall average of a deck's results
  def self.card_result_average
    query = self.where({})
    ids = query.pluck(:id)
    card_results = CardResult.where(result_id: ids)

    card_results_correct = card_results.where(correct: true).count.to_f
    card_results_count = card_results.count.to_f
    card_results_percentage_correct = 0
    puts [card_results_correct, card_results_count].inspect
    if card_results_count != 0
      card_results_percentage_correct = (card_results_correct / card_results_count) * 100.0
    end
    puts card_results_percentage_correct.inspect
    "#{card_results_percentage_correct.round(2) }%"
  end

  # Returns the deck name, result id, and percentage correct (from card_results)
  def to_h
    card_results_correct = card_results.select(&:correct?).length.to_f
    card_results_count = card_results.length.to_f
    card_results_percentage_correct = 0
    if card_results_count != 0
      card_results_percentage_correct = (card_results_correct / card_results_count) * 100.0
    end
    "#{card_results_percentage_correct.round(2) }%"
  end

  def to_s
    "#{deck.name} Result #{id}: #{self.to_h}"
  end
  # has_many :card_results
end
