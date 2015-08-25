# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           not null
#  roles                  :string           is an Array
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  department_id          :integer
#  mobile                 :integer
#  employee_nr            :string
#  image                  :string
#  emp_id                 :string
#  profession_id          :integer
#  home_address           :string
#  home_area_code         :string
#  home_area              :string
#  roles_mask             :integer
#  gender                 :string
#  address                :string
#  birth_date             :date
#

class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include User::Role

  mount_uploader :image, ImageUploader

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  belongs_to :department
  belongs_to :profession
  has_and_belongs_to_many :skills
  has_many :monthly_reports
  has_many :dynamic_forms
  has_many :submissions

  validates :first_name,     presence: true
  validates :last_name,      presence: true
  validates :initials,       uniqueness: true
  validates :mobile,         uniqueness: true
  validates :department_id,  presence: true
  validates :roles,          presence: true


  # Worker
  has_many :user_tasks, :dependent => :destroy
  has_many :tasks, :through => :user_tasks

  has_many :user_languages, :dependent => :destroy
  has_many :languages, :through => :user_languages

  has_many :projects, :through => :tasks
  has_many :hours_spents
  has_many :categories, :through => :projects
  has_many :favorites, :dependent => :destroy
  has_many :kids, :dependent => :destroy
  has_many :user_certificates, :dependent => :destroy
  has_many :certificates, :through => :user_certificates

  scope :from_department,  ->(department) { where('department_id = ?',
                                                  department.id) }


  scope :with_certificate, ->(certificate) { joins(:certificates)
    .where('certificate_id = ?', certificate.id) }

  scope :with_skill, ->(skill) { joins(:skills)
    .where('skill_id = ?', skill.id) }

  attr_reader :expiry_date

  GENDER_TYPES = %W(- mann dame )
  def name
    "#{ first_name } #{ last_name }"
  end

  def full_last_name
    "#{ last_name } #{ first_name }".strip
  end

  def build_initials
    if not User.where(initials: self.initials_v1).exists?
      self.initials ||= self.initials_v1
    elsif not User.where(initials: self.initials_v1).exists?
      self.initials ||= self.initials_v2
    end
  end

  def initials_v1
    "#{ first_name[0] + last_name[0,3] }".upcase
  end

  def initials_v2
    "#{ first_name[0,2] + last_name[0,2] }".upcase
  end

  before_save :init
  def init
    self.initials ||= self.build_initials
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

  def age
    return if birth_date.blank?
    now = Time.now.utc.to_date
    now.year - self.birth_date.year #- (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end

  # Heavy to load all users. Perhaps set the role with
  # user.worker == true if sorting on role_mask is to hard.

  def self.with_role(role)
    User.all.select { |u| u.is? role }
  end

  def is?(role)
    roles.include? role.to_sym
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
