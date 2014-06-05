class User < ActiveRecord::Base
  ROLES = %w[admin leader project_leader worker economy]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def has_role?(role)
    roles.include? role.to_s
  end

  validates :first_name, :presence => true
  validates :last_name,  :presence => true

  def name
    "#{first_name} #{last_name}"
  end

end
