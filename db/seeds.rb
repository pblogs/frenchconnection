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

Fabricate(:customer_message, text: 'Jeg er 30 minutter forsinket. Beklager så mye.')
Fabricate(:customer_message, text: 'Vi er ferdig for i dag. Vi kommer tilbake i morgen.')
Fabricate(:customer_message, text: 'Vi er ferdige med jobben. Vi håper du blir fornøyd.')


elektro = Fabricate(:department, id: 1, title: 'Elektro')
stilas  = Fabricate(:department, id: 2, title: 'Stilas')

Fabricate(:user, department: elektro, first_name: 'Even',  last_name: 'Elektro')
Fabricate(:user, department: stilas,  first_name: 'Stian', last_name: 'Stilas')
