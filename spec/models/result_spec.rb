require 'rails_helper'
# require_relative 'deck'
# require_relative 'card'
# require_relative 'result'
# require_relative 'card_result'

RSpec.describe Result, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '#to_s' do
    it 'returns the deck name, result id, and percentage correct (from card_results)' do
      # Creates a deck, cards, a result, and card results
      deck = Deck.create(id: 999, name: "Salads")
      card1 = Card.create(id: 996, header: "Toppings", lines: "Parmesian, Crutons, or Bacon Bits?", blank: "Parmesian", deck_id: 999)
      card2 = Card.create(id: 997, header: "Dressings", lines: "Italian, 1 Thousand Island, or Caesar?" , blank: "Caesar", deck_id: 999)
      card3 = Card.create(id: 998, header: "Protein", lines: "Beef, Chicken, or Salmon?", blank: "Chicken", deck_id: 999)
      card4 = Card.create(id: 999, header: "Leafs", lines: "Arugula, Romain, or Spinach?" , blank: "Romain", deck_id: 999)
      result1 = Result.create(id: 998, deck_id:999)
      card1_result1 = CardResult.create(id: 992, result_id: 998, card_id: 996, correct: false)
      card2_result1 = CardResult.create(id: 993, result_id: 998, card_id: 997, correct: false)
      card3_result1 = CardResult.create(id: 994, result_id: 998, card_id: 998, correct: true)
      card4_result1 = CardResult.create(id: 995, result_id: 998, card_id: 999, correct: true)

      expect(result1.to_s).to eql("Salads Result 998: 50.0%")
    end
  end

  describe '.card_result_average' do
    it "returns the overall average of a deck's results" do
      # Creates a deck, cards, results, and card results
      deck = Deck.create(id: 999, name: "Salads")
      card1 = Card.create(id: 996, header: "Toppings", lines: "Parmesian, Crutons, or Bacon Bits?", blank: "Parmesian", deck_id: 999)
      card2 = Card.create(id: 997, header: "Dressings", lines: "Italian, 1 Thousand Island, or Caesar?" , blank: "Caesar", deck_id: 999)
      card3 = Card.create(id: 998, header: "Protein", lines: "Beef, Chicken, or Salmon?", blank: "Chicken", deck_id: 999)
      card4 = Card.create(id: 999, header: "Leafs", lines: "Arugula, Romain, or Spinach?" , blank: "Romain", deck_id: 999)
      result1 = Result.create(id: 998, deck_id:999)
      result2 = Result.create(id: 999, deck_id:999)
      card1_result1 = CardResult.create(id: 992, result_id: 998, card_id: 996, correct: false)
      card2_result1 = CardResult.create(id: 993, result_id: 998, card_id: 997, correct: false)
      card3_result1 = CardResult.create(id: 994, result_id: 998, card_id: 998, correct: true)
      card4_result1 = CardResult.create(id: 995, result_id: 998, card_id: 999, correct: true)
      card1_result2 = CardResult.create(id: 996, result_id:999, card_id:996, correct: false)
      card2_result2 = CardResult.create(id: 997, result_id:999, card_id:997, correct: true)
      card3_result2 = CardResult.create(id: 998, result_id:999, card_id:998, correct: true)
      card4_result2 = CardResult.create(id: 999, result_id:999, card_id:999, correct: true)

      expect(Result.card_result_average).to eql("Result Avg: 62.5%")
    end
  end
end
