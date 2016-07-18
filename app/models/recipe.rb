class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :access_level

  def self.publics
    Recipe.joins(:access_levels).where(:access_level => { :name => 'Public' })
  end

  def self.internals
    Recipe.joins(:access_levels).where(:access_level => { :name => 'Internal' })
  end

  def self.users(user)
    Recipe.joins(:access_levels).where(:access_level => { :name => 'Private' }, :user => user)
  end

  def has_access(user)
    if self.access_level.name == 'Internal'
      return true
    elsif self.access_level.name == 'Private'
      return user == self.user || user.is_admin
    end
  end
end
