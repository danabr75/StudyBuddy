class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_results, dependent: :destroy

  def self.search(text)
    # Converts Card class to ActiveRecord_Relation, in case it isn't already
    # TODO - figure out why it won't work w/o the .where({})
    query = self.where({})
    if text
      query.where("header ILIKE ?", "%#{text}%").or(query.where("lines ILIKE ?", "%#{text}%")).or(query.where("blank ILIKE ?", "%#{text}%"))
    else
      query
    end
  end
end