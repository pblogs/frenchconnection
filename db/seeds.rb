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


Department.destroy_all
User.destroy_all
Task.destroy_all



elektro  = Department.where(id: 1, title: 'Elektro').first_or_create
stilas   = Department.where(id: 2, title: 'Stilas').first_or_create
snekkere = Department.where(id: 3, title: 'Snekkere').first_or_create

Fabricate(:user, department: elektro, first_name: 'Even',  
          last_name: 'Elektro', email: 'even@elektro.no')
Fabricate(:user, department: stilas,  first_name: 'Stian', 
          last_name: 'Stilas', email: 'stian@stilas.no')


# Prosjektledere:
Fabricate(:user, roles: [:project_leader], first_name: "Truls", 
          mobile:  41413017, last_name: "Bratfoss") 
Fabricate(:user, roles: [:project_leader], first_name: "Arild", 
          mobile:  94147807, last_name: "Jonassen")
Fabricate(:user, roles: [:project_leader], first_name: "Martin", 
          mobile:  93441707, last_name: "Stabenfeldt")

# Generic accounts
Fabricate(:user, roles: [:worker], department: snekkere, 
          first_name: "Arbeider", last_name: "Arbeider")
Fabricate(:user, roles: [:project_leader], mobile:  'prosjektleder', 
          first_name: 'Prosjekt', last_name: 'Leder')

# Medarbeidere snekkere

Fabricate(:user, roles: [:worker], department: snekkere, 
          first_name: "Avni", last_name: "Lymany", mobile: 47625905)
Fabricate(:user, roles: [:worker], department: snekkere, 
          first_name: "Danni", last_name: "Runge", mobile: 91135576)
Fabricate(:user, roles: [:worker], department: snekkere, 
          first_name: "Alexander", last_name: "Børresen", mobile: 48159427)
