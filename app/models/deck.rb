class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy

  #query shortcut
  scope :ordered_by_name, -> { order(name: :asc) }

  #custom relation name, not tied directly to model name
  #has_many :reviewer_comments, -> { where(is_reviewer_comment: true) }, dependent: :destroy, class_name: 'Comment'

  # # bad way
  # def reviewer_comments
  #   comments.where(is_reviewer_comment: true)
  # end

  validates :name, presence: true

  #def initialize *args
    #super *args
    #self.title = "title not found"
  #end
end
