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
Fabricate(:task_type, title: 'Maling')
Fabricate(:task_type, title: 'Muring')
Fabricate(:task_type, title: 'Forskaling')
Fabricate(:paint, title: 'Acryl')
Fabricate(:paint, title: 'Murmaling' )
Fabricate(:paint, title: 'Grunning' )
