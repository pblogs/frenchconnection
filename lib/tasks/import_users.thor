class Users < Thor

  desc "import <filename>", "Import users from Excel"
  def import(filename)
    puts "Loading Rails environment..."
    require File.expand_path('config/environment.rb')
    require 'roo'

    if filename.match 'xlsx'
      s = Roo::Excelx.new(filename)
    else
      s = Roo::Excel.new(filename)
    end
    employees = []

    s.each {|hash| employees << hash}
    employees.shift # Remove header 
    employees.each do |e|
      first_name     = e[0].strip
      last_name      = e[1].strip

      # Department
      department_title = e[2].strip
      department = Department.where(title: department_title).first_or_create

      # Profession
      profession_title = e[3].strip
      profession = Profession.where(title: profession_title).first_or_create

      mobile         = e[4].gsub!(/\s/, '') rescue nil
      email          = e[5].strip

      home_address   = e[6].strip
      home_area_code = e[7]
      home_area      = e[8].strip rescue nil
      password       = 'lkjlkjlkj8kjsdfsdkfj8kjhskjdfkjsdf3n'

      u = User.new(first_name: first_name, last_name: last_name, 
                   department: department, profession: profession, email: email,
                   home_address: home_address, home_area_code: home_area_code,
                   home_area: home_area, mobile: mobile, roles: ['worker'],
                   password: password, password_confirmation: password)
      if u.save
        puts "Importing #{first_name} #{last_name}"
      else
        puts "Could not save  #{first_name} #{last_name}"
        u.errors.each { |k,v| p "#{k} - #{v}" }
        puts "\n"
      end

    end



  end
end
