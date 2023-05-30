class UserRole < ApplicationRecord
  VALID_ROLE_NAMES = %w[admin].freeze
  validates :name, inclusion: { in: VALID_ROLE_NAMES, message: "is not a valid value" }

  belongs_to :user
end
