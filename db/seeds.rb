User.destroy_all
Project.destroy_all
Customer.destroy_all
Department.destroy_all
Profession.destroy_all

# Customers
sporveiene    = Fabricate(:customer, name: 'Oslo Sporveier AS')
ostbanehallen = Fabricate(:customer, name: 'Østbanehallen')
slottet       = Fabricate(:customer, name: 'Det kongelige slott')


# Custom message.
Fabricate(:customer_message,
          text: 'Vi er ferdig for i dag. Vi kommer tilbake i morgen.')
Fabricate(:customer_message,
          text: 'Vi er ferdige med jobben. Vi håper du blir fornøyd.')


# Departments
service_avdeling = Department.create(title: '69850')
@d545  = Department.create(title: 'Avd. 545 Bratfoss')
@d546  = Department.create(title: 'Avd. 546 Vindusverksted')
@d532 = Department.create(title: 'Avd. 532 Tak og fasade')


# Professions
murer      = Profession.create(title: 'bricklayer')
maler      = Profession.create(title: 'painter')
@snekker   = Profession.create(title: 'carpenter')
elektriker = Profession.create(title: 'electrician')


# A user has one of these roles.
# - (lærling, sven, mester, prosjektleder)
# - :apprentice, :sven, :master, :project_leader
Fabricate(:user, department: service_avdeling, profession: elektriker,
          first_name: 'Even', last_name: 'Elektro')
maren_maler = Fabricate(:user, department: service_avdeling, profession: maler,
                        first_name: 'Maren',  last_name: 'Maler')
Fabricate(:user, department: service_avdeling, profession: elektriker,
          first_name: 'Espen', last_name: 'Elektro')

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


Fabricate(:user, department: service_avdeling, roles: [:project_leader],
          first_name: "Prosjekt", mobile:  00000002, last_name: "Leder")

@martin = Fabricate(:user, roles: [:project_leader], first_name: "Martin",
          mobile:  93441707, last_name: "Stabenfeldt",
          department: service_avdeling)

Fabricate(:user, roles: [:project_leader], first_name: "Martin Arbeider",
          mobile:  '010583', last_name: "Stabenfeldt",
          department: service_avdeling)

# Medarbeidere snekkere
Fabricate(:user, roles: [:worker], department: service_avdeling,
          first_name: "Avni", last_name: "Lymany", mobile: 47625905,
          profession: @snekker)

danni = Fabricate(:user, roles: [:worker],
                  department: service_avdeling, first_name: "Danni",
                  last_name: "Runge", mobile: 91135576, profession: @snekker)
snekker2 = Fabricate(:user, roles: [:worker],
                  department: service_avdeling, first_name: "Snekker",
                  last_name: "Olsen", profession: @snekker)

snekker_kari = Fabricate(:user, roles: [:worker],
                  department: service_avdeling, first_name: "Snekker",
                  last_name: "Kari", profession: @snekker)

Fabricate(:user, roles: [:worker],
          department: service_avdeling, first_name: "Alexander",
          last_name: "Børresen", mobile: 48159427, profession: @snekker)

# Projects
@ryen = Fabricate(:project, name: 'Nytt tak på Ryenhallen',
                 customer: sporveiene,
                 sms_employee_if_hours_not_registered: true,
                 department: service_avdeling, user: @martin)

@trapp_slottet = Fabricate(:project, name: 'Trappen på slottet',
                 customer: slottet,
                 department: service_avdeling, user: danni)


# Tasks for Danni - Snekker
skur_ryen = Fabricate(:task, project: @ryen, description: 'Lag et skur')
skur_ryen.users << danni
skur_ryen.users << @martin # Add martin so we have a user that doesn't register
                            # any HoursSpent.

trapp = Fabricate(:task, project: @trapp_slottet, description: 'Ny trapp')
trapp.users << danni
trapp.save

# Tasks for Snekker Kari
snekker_kari_task = Fabricate(:task, project: @ryen, description: 'Lag en bod')
snekker_kari_task.users << snekker_kari
snekker_kari_task.save

# Tasks for Maren - Maler
male_task = Fabricate(:task, project: @ryen, description: 'Mal veggen')
male_task.users << maren_maler
male_task.save

# HoursSpent for Danni - Snekker
# Only for week 1 in 2014
Fabricate(:hours_spent, date: '01.01.2014', hour: 11,
          task: skur_ryen, user: danni, project: @ryen,
          description: 'danni - 11 vanlige timer')

Fabricate(:hours_spent, date: '02.01.2014', overtime_50: 12,
          task: skur_ryen, user: danni, project: @ryen,
          description: 'danni - 12 timer 50% overtid')

Fabricate(:hours_spent, date: '03.01.2014', overtime_100: 13,
          task: skur_ryen, user: danni, project: @ryen,
          description: 'danni - 13 timer 100% overtid')

Fabricate(:hours_spent, date: '04.01.2014', overtime_100: 20,
          task: skur_ryen, user: danni, project: @ryen,
          description: 'danni - 20 timer 100% overtid')


# Snekker Kari
Fabricate(:hours_spent, date: '14.01.2014', overtime_100: 30,
          task: snekker_kari_task, user: snekker_kari, project: @ryen,
          description: 'snekker kari - 30 timer 100% overtid')
Fabricate(:hours_spent, date: '15.01.2014', overtime_100: 10,
          task: snekker_kari_task, user: snekker_kari, project: @ryen,
          description: 'snekker kari - 10 timer 100% overtid')

# More workers with hours on Ryen
9.times do |i|
  i +=1
  user = Fabricate(:user, profession: @snekker, department: @d545)
  user_task = Fabricate(:task, project: @ryen, description: 'div for user')
  user_task.users << user
  user_task.save!
  Fabricate(:hours_spent, date: "01.0#{i}.2014", overtime_100: 30,
             task: user_task, user: user, project: @ryen,
             description: "#{user.name} - 30 timer 100% overtid")
  Fabricate(:hours_spent, date: "01.0#{i}.2014", overtime_50: 52,
             task: user_task, user: user, project: @ryen,
             description: "#{user.name} - 52 timer 50%")
end

#
#
###################

# HoursSpent for Maren Maler
Fabricate(:hours_spent, date: '01.01.2014', hour: 21,
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 21 vanlige timer')

Fabricate(:hours_spent, date: '09.01.2014', overtime_50: 22,
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 22 timer 50% overtid')

Fabricate(:hours_spent, date: '14.01.2014', overtime_100: 23,
          task: male_task, user: maren_maler, project: male_task.project,
          description: 'maren maler 23 timer 100% overtid')

# Certificates
Certificate.destroy_all
truck_cert     = Fabricate(:certificate, title: 'Truck driver')
lift_cert      = Fabricate(:certificate, title: 'Small lift')
climber_cert   = Fabricate(:certificate, title: 'Climber')
bulldozer_cert = Fabricate(:certificate, title: 'Bulldozer cert')


# Locations
Location.destroy_all
Fabricate(:location, name: 'Roof top')
Fabricate(:location, name: 'Construction site')
Fabricate(:location, name: 'Traffic')

# Inventories
Inventory.destroy_all
cat_bulldozer = Fabricate(:inventory, name: 'Cat bulldozer', certificates: [bulldozer_cert])
small_lift    = Fabricate(:inventory, name: 'Small lift', certificates: [lift_cert])
big_lift      = Fabricate(:inventory, name: 'Big lift', certificates: [lift_cert])
truck         = Fabricate(:inventory, name: 'Truck', certificates: [truck_cert])
Fabricate(:inventory, name: 'Concrete blender')

# Workers that can operate these machines
Fabricate(:user, first_name: 'Bobb', last_name: 'Bulldozer')
Fabricate(:user, first_name: 'Tore', last_name: 'Trøkk')
Fabricate(:user, first_name: 'Lise', last_name: 'Lift')

# Skills
Skill.destroy_all
Fabricate(:skill, title: 'welding')
Fabricate(:skill, title: 'painting')
Fabricate(:skill, title: 'digging')
Fabricate(:skill, title: 'driving')
