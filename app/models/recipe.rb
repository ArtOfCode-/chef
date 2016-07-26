class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :access_level
  belongs_to :category
  has_many :favorites
  has_many :comments

  validates :access_level, :presence => true
  validates :title, :presence => true, :length => { :minimum => 6 }

  def self.publics
    AccessLevel.where(:name => 'Public').first.recipes
  end

  def self.internals
    AccessLevel.where(:name => 'Internal').first.recipes
  end

  def self.users(user)
    AccessLevel.where(:name => 'Private').first.recipes.where(:user => user)
  end

  def has_access(user)
    if self.access_level.name == 'Internal'
      return true
    elsif self.access_level.name == 'Private'
      return user == self.user || user.is_admin
    end
  end
end
