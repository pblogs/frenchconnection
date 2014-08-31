# Customers
sporveiene    = Fabricate(:customer, name: 'Oslo Sporveier AS')
ostbanehallen = Fabricate(:customer, name: 'Østbanehallen')


# Custom message.
Fabricate(:customer_message, 
          text: 'Jeg er 30 minutter forsinket. Beklager så mye.')
Fabricate(:customer_message, 
          text: 'Vi er ferdig for i dag. Vi kommer tilbake i morgen.')
Fabricate(:customer_message, 
          text: 'Vi er ferdige med jobben. Vi håper du blir fornøyd.')


# Avdelinger
d545 = Department.create(title: 'Avd. 545 Bratfoss')
d546 = Department.create(title: 'Avd. 546 Vindusverksted')
@d532 = Department.create(title: 'Avd. 532 Tak og fasade')


# Fagkategorier
murer      = Profession.create(title: 'Murer')
maler      = Profession.create(title: 'Maler')
snekker    = Profession.create(title: 'Snekker')
elektriker = Profession.create(title: 'Elektriker')


# A user has one of these roles.
# - (lærling, sven, mester, prosjektleder)
# - :apprentice, :sven, :master, :project_leader
Fabricate(:user, department: d545, profession: elektriker, first_name: 'Even',  
          last_name: 'Elektro', emp_id: '1212121', roles: ["project_leader"])
Fabricate(:user, department: d545, profession: maler, first_name: 'Maren',  
          last_name: 'Maler', emp_id: '1212122', roles: ["project_leader"])
Fabricate(:user, department: d545, profession: elektriker, first_name: 'Espen',  
          last_name: 'Elektro', emp_id: '1212123', roles: ["project_leader"])

# Prosjektledere:
Fabricate(:user, department: d545, roles: [:project_leader],
          first_name: "Truls", mobile:  41413017, last_name: "Bratfoss", emp_id: '1212124') 
Fabricate(:user, department: d545, roles: [:project_leader], 
          first_name: "Arild", mobile:  94147807, last_name: "Jonassen", emp_id: '1212125')
Fabricate(:user, department: d545, roles: [:project_leader], 
          first_name: "Prosjekt", mobile:  00000002, last_name: "Leder", emp_id: '1212126')

Fabricate(:user, roles: [:project_leader], first_name: "Martin",
          mobile:  93441707, last_name: "Stabenfeldt", department: d545, emp_id: '1212127')

# Medarbeidere snekkere
Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Avni", last_name: "Lymany", mobile: 47625905, 
          profession: snekker, emp_id: '1212128')
danni = Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Danni", last_name: "Runge", mobile: 91135576,
          profession: snekker, emp_id: '1212129')
Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Alexander", last_name: "Børresen", mobile: 48159427,
          profession: snekker, emp_id: '1212130')

# Projects
# ryen = Fabricate(:project, name: 'Nyt tak på Ryenhallen', customer: sporveiene, department: @d532)

# Tasks
# t = Fabricate(:task, project: ryen, description: 'Legg ny takpapp')
# t.users << danni
# t.save

# HoursSpent
# Fabricate(:hours_spent, hour: 8, task: t, user: danni, description: 'malt')
# Fabricate(:hours_spent, hour: 8, task: t, user: danni, description: 'malt')
