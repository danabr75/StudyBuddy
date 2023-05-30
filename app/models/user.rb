class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :invitable, :timeoutable, :lockable
  has_many :user_roles

  def add_role!(name)
    name = name.to_s
    return false if roles.include?(name)

    user_roles.create!(name: name)
  end

  def remove_role!(name)
    name = name.to_s
    return false if roles.include?(name)

    user_roles.where(name: name).destroy_all
  end

  # DANGEROUS!
  # Delegating this methods to 'ability' on user gives them more power than they should have
  # - Appears to always return 'true' for any block permissions
  # delegate :can?, :cannot?, :to => :ability
  def current_ability
    @current_ability ||= Ability.new(self)
  end

  def roles
    user_roles.pluck(:name)
  end

  def can? *args
    current_ability.can?(*args)
  end

  def cannot? *args
    current_ability.cannot?(*args)
  end
end
