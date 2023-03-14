class Card < ApplicationRecord
  belongs_to :deck
  has_many :card_results, dependent: :destroy

  def self.search(text)
    # Converts Card class to ActiveRecord_Relation, in case it isn't already
    # TODO - figure out why it won't work w/o the .where({})
    query = self.where({})
    if text
      if query.where("header LIKE ?", "%#{text}%").or(query.where("lines LIKE ?", "%#{text}%")).or(query.where("blank LIKE ?", "%#{text}%"))
        query.where("header LIKE ?", "%#{text}%").or(query.where("lines LIKE ?", "%#{text}%")).or(query.where("blank LIKE ?", "%#{text}%"))
      else
        query
      end
    else
      query
    end
  end
end