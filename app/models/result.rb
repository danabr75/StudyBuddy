class Result < ApplicationRecord
  belongs_to :deck
  has_many :card_results, inverse_of: :result, dependent: :destroy
  accepts_nested_attributes_for :card_results

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
    "Result Avg: #{card_results_percentage_correct.round(2) }%"
  end

  def to_s
    card_results_correct = card_results.where(correct: true).count.to_f
    card_results_count = card_results.count.to_f
    card_results_percentage_correct = 0
    puts [card_results_correct, card_results_count].inspect
    if card_results_count != 0
      card_results_percentage_correct = (card_results_correct / card_results_count) * 100.0
    end
    puts card_results_percentage_correct.inspect
    "#{deck.name} Result #{id}: #{card_results_percentage_correct.round(2) }%"
  end
  # has_many :card_results
end
