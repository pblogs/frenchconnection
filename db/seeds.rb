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


Fabricate(:customer_message, text: 'Jeg er 30 minutter forsinket. Beklager så mye.')
Fabricate(:customer_message, text: 'Vi er ferdig for i dag. Vi kommer tilbake i morgen.')
Fabricate(:customer_message, text: 'Vi er ferdige med jobben. Vi håper du blir fornøyd.')


elektro = Department.where(id: 1, title: 'Elektro').first_or_create
stilas  = Department.where(id: 2, title: 'Stilas').first_or_create

Fabricate(:user, department: elektro, first_name: 'Even',  
          last_name: 'Elektro', email: 'even@elektro.no', password: 'even@elektro.no', password_confirmation: 'even@elektro.no')
Fabricate(:user, department: stilas,  first_name: 'Stian', 
          last_name: 'Stilas', email: 'stian@stilas.no', password: 'stian@stilas.no', password_confirmation: 'stian@stilas.no', )

User.where(email: 'worker@worker.no', password: 'worker@worker.no', password_confirmation: 'worker@worker.no', first_name: 'Hard', last_name: 'Worker').create!
User.where(email: 'project@leader.no', password: 'project@leader.no', password_confirmation: 'project@leader.no', first_name: 'Prosjekt', last_name: 'Leder', roles: [:project_leader]).create!
