class RegistrationsController < Devise::RegistrationsController
  def create
    super
    Rails.cache.write('users_newest') do
      User.all.order(:created_at => :desc)
    end
    Rails.cache.write('users_recipes') do
      User.all.joins(:recipes).group('users.id').order('COUNT(users.id) DESC')
    end
    Rails.cache.write('users_alpha') do
      User.all.order(:username => :asc)
    end
  end
end
