class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :access_level
  has_many :favorites

  validates :access_level, :presence => true
  validates :title, :presence => true, :length => { :minimum => 15 }

  def self.publics
    #Recipe.joins(:access_levels).where(:access_level => { :name => 'Public' })
    AccessLevel.where(:name => 'Public').first.recipes
  end

  def self.internals
    #Recipe.joins(:access_levels).where(:access_level => { :name => 'Internal' })
    AccessLevel.where(:name => 'Internal').first.recipes
  end

  def self.users(user)
    #Recipe.joins(:access_levels).where(:access_level => { :name => 'Private' }, :user => user)
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
