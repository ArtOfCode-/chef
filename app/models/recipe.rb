class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :access_level

  def has_access(user)
    if self.access_level.name == 'Internal'
      return true
    elsif self.access_level.name == 'Private'
      return user == self.user || user.is_admin
    end
  end
end
