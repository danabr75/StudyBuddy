class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, :timeoutable, :lockable

  # DANGEROUS!
  # Delegating this methods to 'ability' on user gives them more power than they should have
  # - Appears to always return 'true' for any block permissions
  # delegate :can?, :cannot?, :to => :ability
  def current_ability
    @current_ability ||= Ability.new(self)
  end

  def can? *args
    current_ability.can?(*args)
  end

  def cannot? *args
    current_ability.cannot?(*args)
  end
end
