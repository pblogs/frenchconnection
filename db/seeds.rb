# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#
Fabricate(:customer, name: 'Oslo Sporveier AS')
Fabricate(:customer, name: 'Østbanehallen')

Fabricate(:artisan)
Fabricate(:task_type)
Fabricate(:task_type)
Fabricate(:task_type)
Fabricate(:paint)
Fabricate(:paint)
Fabricate(:paint)
