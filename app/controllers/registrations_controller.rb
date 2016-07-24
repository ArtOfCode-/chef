class RegistrationsController < Devise::RegistrationsController
  def create
    super
    Rails.cache.write('users_newest', User.all.order(:created_at => :desc))
    Rails.cache.write('users_recipes', User.all.joins(:recipes).group('users.id').order('COUNT(users.id) DESC'))
    Rails.cache.write('users_alpha', User.all.order(:username => :asc))
  end
end
