User.destroy_all
Project.destroy_all
Customer.destroy_all
Department.destroy_all
Profession.destroy_all

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
          last_name: 'Elektro')
maren_maler = Fabricate(:user, department: d545, profession: maler, first_name: 'Maren',  
          last_name: 'Maler')
Fabricate(:user, department: d545, profession: elektriker, first_name: 'Espen',  
          last_name: 'Elektro')

# Prosjektledere:
Fabricate(:user, department: d545, roles: [:project_leader],
          first_name: "Truls", mobile:  41413017, last_name: "Bratfoss") 
Fabricate(:user, department: d545, roles: [:project_leader], 
          first_name: "Arild", mobile:  94147807, last_name: "Jonassen")
Fabricate(:user, department: d545, roles: [:project_leader], 
          first_name: "Prosjekt", mobile:  00000002, last_name: "Leder")

@martin = Fabricate(:user, roles: [:project_leader], first_name: "Martin",
          mobile:  93441707, last_name: "Stabenfeldt", department: d545)

# Medarbeidere snekkere
Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Avni", last_name: "Lymany", mobile: 47625905, 
          profession: snekker)
danni = Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Danni", last_name: "Runge", mobile: 91135576,
          profession: snekker)
Fabricate(:user, roles: [:worker], department: snekker, department: d545,
          first_name: "Alexander", last_name: "Børresen", mobile: 48159427,
          profession: snekker)

# Projects
ryen = Fabricate(:project, name: 'Nyt tak på Ryenhallen', customer: sporveiene, department: @d532, starred: true, user: @martin)

# Tasks for Danni - Snekker
t = Fabricate(:task, project: ryen, description: 'Legg ny takpapp')
t.users << danni
t.save

# Tasks for Maren - Maler
t = Fabricate(:task, project: ryen, description: 'Mal veggen')
t.users << maren_maler
t.save

# HoursSpent for Danni - Snekker
Fabricate(:hours_spent, hour: 8, task: t, user: danni, description: '8 vanlige timer')
Fabricate(:hours_spent, overtime_50: 8, task: t, user: danni, description: '8 timer 50% overtid')
Fabricate(:hours_spent, overtime_100: 8, task: t, user: danni, description: '8 timer 100% overtid')

# HoursSpent for Maren Maler
Fabricate(:hours_spent, hour: 10, task: t, user: maren_maler, description: 'maren maler 10 vanlige timer')
Fabricate(:hours_spent, overtime_50: 10, task: t, user: maren_maler, description: 'maren maler 10 timer 50% overtid')
Fabricate(:hours_spent, overtime_100: 10, task: t, user: maren_maler, description: 'maren maler 10 timer 100% overtid')
