class User < ActiveRecord::Base
  ROLES = %w[admin leader project_leader worker economy]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :department

  def has_role?(role)
    roles.include? role.to_s
  end

  validates :first_name, :presence => true
  validates :last_name,  :presence => true

  # Worker
  has_and_belongs_to_many :tasks
  has_many :projects, :through => :tasks
  has_many :hours_spents

  def name
    "#{first_name} #{last_name}"
  end

end
