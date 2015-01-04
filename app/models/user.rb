# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  encrypted_password     :string(255)      not null
#  roles                  :string(255)      is an Array
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string(255)
#  image                  :string(255)
#  emp_id                 :string(255)
#  profession_id          :integer
#  home_address           :string(255)
#  home_area_code         :string(255)
#  home_area              :string(255)
#

class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include User::Role

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  belongs_to :department
  belongs_to :profession
  has_and_belongs_to_many :certificates
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :skills

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :mobile,     uniqueness: true
  validates :department_id,  presence: true
  validates :roles,  presence: true

  # Worker
  has_many :user_tasks
  has_many :tasks, through: :user_tasks
  has_many :projects, :through => :tasks
  has_many :hours_spents
  has_many :categories, :through => :projects
  has_many :favorites, dependent: :destroy


  def name
    "#{ first_name } #{ last_name }"
  end

  def full_last_name
    "#{ last_name } #{ first_name }".strip
  end

  def avatar
    image.url.present? ? image.url : "http://robohash.org/#{name}"
  end

  def full_name
    "#{ first_name } #{ last_name }".strip
  end

  def full_name=(name)
    name = name.split(' ')
    self.last_name  = name.pop
    self.first_name = name.join(' ')
  end

  def project_departments
    Department.find(owns_project_ids) if owns_project_ids
  end

  def owns_projects
    Project.where(user_id: id).all
  end

  def owns_project_ids
    owns_projects.pluck(:department_id).compact
  end

  def self.roles_to_mask(roles)
    (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  # Heavy to load all users. Perhaps set the role with 
  # user.worker == true if sorting on role_mask is to hard.
  def self.workers
    User.all.select { |u| u.is? :worker }
  end

  protected

  def send_devise_notification(notification, *args)
    if new_record? || changed?
      pending_notifications << [notification, args]
    else
      token = args.first
      reset_url =  "#{edit_user_password_url(self,
        reset_password_token: token,
        host: ENV['DOMAIN'] || 'allieroforms.dev' )}"
      msg = "Klikk her for nytt passord hos Orwapp: #{reset_url}"
      Sms.send_msg(to: "47#{mobile}", msg: msg)
    end
  end

  def after_resetting_password_path_for(resource)
    root_path
  end

  def avatar_path
    "users/#{ name.parameterize }.jpg"
  end
end
