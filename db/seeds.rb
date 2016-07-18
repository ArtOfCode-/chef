# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

access_levels = [
  { name: 'Public', description: 'Will be visible to everyone, including logged-out users.' },
  { name: 'Internal', description: 'Will be visible to every logged-in user.' },
  { name: 'Private', description: 'Will only be visible to you.' }
]

AccessLevel.create(access_levels)
