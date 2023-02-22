class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_results, dependent: :destroy

#Search does work, but doesn't specify the deck...
  def self.search(text)
    query = self.where({})
    if text
      if query.where(header: text).or(query.where(lines: text)).or(query.where(blank: text))
        query.where(header: text).or(query.where(lines: text)).or(query.where(blank: text))
      else
        query
      end
    else
      query
    end
  end
end