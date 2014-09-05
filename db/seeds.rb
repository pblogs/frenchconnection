User.destroy_all
Project.destroy_all
Customer.destroy_all
Department.destroy_all
Profession.destroy_all

# Customers
sporveiene    = Fabricate(:customer, name: 'Oslo Sporveier AS')
ostbanehallen = Fabricate(:customer, name: 'Østbanehallen')
slottet       = Fabricate(:customer, name: 'Det kongelige slott', starred: true)


# Custom message.
Fabricate(:customer_message, 
          text: 'Jeg er 30 minutter forsinket. Beklager så mye.')
Fabricate(:customer_message, 
          text: 'Vi er ferdig for i dag. Vi kommer tilbake i morgen.')
Fabricate(:customer_message, 
          text: 'Vi er ferdige med jobben. Vi håper du blir fornøyd.')


# Avdelinger
service_avdeling = Department.create(title: '69850')
d545  = Department.create(title: 'Avd. 545 Bratfoss')
d546  = Department.create(title: 'Avd. 546 Vindusverksted')
@d532 = Department.create(title: 'Avd. 532 Tak og fasade')


# Fagkategorier
murer      = Profession.create(title: 'Murer')
maler      = Profession.create(title: 'Maler')
snekker    = Profession.create(title: 'Snekker')
elektriker = Profession.create(title: 'Elektriker')


# A user has one of these roles.
# - (lærling, sven, mester, prosjektleder)
# - :apprentice, :sven, :master, :project_leader
Fabricate(:user, department: service_avdeling, profession: elektriker, first_name: 'Even',  
          last_name: 'Elektro')
maren_maler = Fabricate(:user, department: service_avdeling, profession: maler, first_name: 'Maren',  
          last_name: 'Maler')
Fabricate(:user, department: service_avdeling, profession: elektriker, first_name: 'Espen',  
          last_name: 'Elektro')

# Folk
Fabricate(:user, department: service_avdeling, roles: [:worker],
          first_name: "Stein", mobile:  95104040, last_name: "Hesstvedt") 
Fabricate(:user, department: service_avdeling, roles: [:project_leader],
          first_name: "Joachim", mobile: 92094426, last_name: "Stray") 
Fabricate(:user, department: service_avdeling, roles: [:project_leader],
          first_name: "Anders", mobile: 92848717, last_name: "Blom Nilsen") 

# Prosjektledere:
Fabricate(:user, department: service_avdeling, roles: [:project_leader],
          first_name: "Truls", mobile:  41413017, last_name: "Bratfoss") 
Fabricate(:user, department: service_avdeling, roles: [:project_leader], 
          first_name: "Arild", mobile:  94147807, last_name: "Jonassen")

# Dummy kontoer for testing
dummy_worker = Fabricate(:user, department: service_avdeling, roles: [:worker], 
          first_name: "Working", mobile:  00000001, last_name: "Man", 
          profession: snekker)
Fabricate(:user, department: service_avdeling, roles: [:project_leader], 
          first_name: "Prosjekt", mobile:  00000002, last_name: "Leder")

@martin = Fabricate(:user, roles: [:project_leader], first_name: "Martin",
          mobile:  93441707, last_name: "Stabenfeldt", department: service_avdeling)

# Medarbeidere snekkere
Fabricate(:user, roles: [:worker], department: snekker, department: service_avdeling,
          first_name: "Avni", last_name: "Lymany", mobile: 47625905, 
          profession: snekker)
danni = Fabricate(:user, roles: [:worker], department: snekker, department: service_avdeling,
          first_name: "Danni", last_name: "Runge", mobile: 91135576,
          profession: snekker)
Fabricate(:user, roles: [:worker], department: snekker, department: service_avdeling,
          first_name: "Alexander", last_name: "Børresen", mobile: 48159427,
          profession: snekker)

# Projects
ryen = Fabricate(:project, name: 'Nytt tak på Ryenhallen', 
                 customer: sporveiene, 
                 department: service_avdeling, starred: true, user: @martin)

# Tasks for dummy_worker - Snekker
snekker_task = Fabricate(:task, project: ryen, description: 'Legg ny takpapp')
snekker_task.users << dummy_worker
snekker_task.save

# Tasks for Maren - Maler
male_task = Fabricate(:task, project: ryen, description: 'Mal veggen')
male_task.users << maren_maler
male_task.save

# HoursSpent for Danni - Snekker
Fabricate(:hours_spent, created_at: '01.01.2014', hour: 11,         
          task: snekker_task, user: danni, project: snekker_task.project,
          description: '11 vanlige timer')

Fabricate(:hours_spent, created_at: '09.01.2014', overtime_50: 12,  
          task: snekker_task, user: danni, project: snekker_task.project,
          description: '12 timer 50% overtid')

Fabricate(:hours_spent, created_at: '14.01.2014', overtime_100: 13, 
          task: snekker_task, user: danni, project: snekker_task.project,
          description: '13 timer 100% overtid')

# HoursSpent for Maren Maler
Fabricate(:hours_spent, created_at: '01.01.2014', hour: 21,         
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 21 vanlige timer')

Fabricate(:hours_spent, created_at: '09.01.2014', overtime_50: 22,  
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 22 timer 50% overtid')

Fabricate(:hours_spent, created_at: '14.01.2014', overtime_100: 23, 
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 23 timer 100% overtid')
