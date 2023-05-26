class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :results, dependent: :destroy

  #query shortcut
  scope :ordered_by_name, -> { order(name: :asc) }

  #custom relation name, not tied directly to model name
  #has_many :reviewer_comments, -> { where(is_reviewer_comment: true) }, dependent: :destroy, class_name: 'Comment'

  # # bad way
  # def reviewer_comments
  #   comments.where(is_reviewer_comment: true)
  # end

  validates :name, presence: true

  def self.search(text)
    # Converts Card class to ActiveRecord_Relation, in case it isn't already
    # TODO - figure out why it won't work w/o the .where({})
    query = self.where({})
    if text
      query.where("name LIKE ?", "%#{text}%")
    else
      query
    end
  end
end
