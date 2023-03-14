require 'rails_helper'

RSpec.describe Card, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  describe '.search' do
    it "returns the count 2 when searching for 'ote' from the Games deck" do
      # Creates a deck, and cards
      deck1 = Deck.create(id: 998, name: "Games")
      deck2 = Deck.create(id: 999, name: "Shows")

      card1 = Card.create(id: 996, header: "Bioshock - Quotes", lines: "The mind of the subject will desperately struggle to create memories where none exist...", blank: "R. Lutece, Bioshock: Infinite", deck_id: 998)
      card2 = Card.create(id: 997, header: "Valorant - Abilities", lines: "Alarmbot, Turret, Nanoswarm, Lockdown", blank: "Killjoy", deck_id: 998)
      card3 = Card.create(id: 998, header: "Westworld - Quotes", lines: "If there's one thing I know about human nature, it's that your stupidity is only eclipsed by your laziness.", blank: "Maeve", deck_id: 999)
      card4 = Card.create(id: 999, header: "Resident Evil - Quotes", lines: "You were almost a Jill Sandwich", blank: "Barry Burton, Resident Evil", deck_id: 998)

      expect(deck1.cards.search("ote").count).to eql(2)
    end

    it "returns the count 3 when searching for 'ote' from Cards" do
      # Creates a deck, and cards
      deck1 = Deck.create(id: 998, name: "Games")
      deck2 = Deck.create(id: 999, name: "Shows")

      card1 = Card.create(id: 996, header: "Bioshock - Quotes", lines: "The mind of the subject will desperately struggle to create memories where none exist...", blank: "R. Lutece, Bioshock: Infinite", deck_id: 998)
      card2 = Card.create(id: 997, header: "Valorant - Abilities", lines: "Alarmbot, Turret, Nanoswarm, Lockdown", blank: "Killjoy", deck_id: 998)
      card3 = Card.create(id: 998, header: "Westworld - Quotes", lines: "If there's one thing I know about human nature, it's that your stupidity is only eclipsed by your laziness.", blank: "Maeve", deck_id: 999)
      card4 = Card.create(id: 999, header: "Resident Evil - Quotes", lines: "You were almost a Jill Sandwich", blank: "Barry Burton, Resident Evil", deck_id: 998)

      expect(Card.search("qu").count).to eql(3)
    end
  end

end