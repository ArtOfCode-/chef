class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_many :recipes
  has_many :favorites
  has_many :comments

  def public_recipes
    AccessLevel.where(:name => 'Public').first.recipes.where(:user => self).order(:created_at => :desc)
  end

  def internal_recipes
    AccessLevel.where(:name => 'Internal').first.recipes.where(:user => self).order(:created_at => :desc)
  end

  def private_recipes
    Recipe.users(self).order(:created_at => :desc)
  end
end
