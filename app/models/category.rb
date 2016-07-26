class Category < ApplicationRecord
  has_many :recipes

  validates :name, :presence => true, :length => { :minimum => 3, :maximum => 30 }
  validates :description, :length => { :maximum => 255 }
end
