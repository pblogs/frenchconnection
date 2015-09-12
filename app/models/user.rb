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
#  relatives              :text
#  initials               :string
#

# Users
class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  include User::Role

  mount_uploader :image, ImageUploader

  devise :database_authenticatable, :recoverable, :rememberable, :trackable

  belongs_to :department
  belongs_to :profession
  # rubocop:disable all
  has_and_belongs_to_many :skills
  # rubocop:enable all

  ##############
  #
  # The hourly reports are going to be rewritten
  #
  # has_many :monthly_reports
  has_many :hours_spents

  has_many :dynamic_forms
  has_many :submissions

  validates :first_name, :last_name, :roles, presence: true
  validates :initials,       uniqueness: true
  validates :mobile,         uniqueness: true

  has_many :user_tasks, dependent: :destroy
  has_many :tasks, through: :user_tasks

  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages

  has_many :projects, through: :tasks
  has_many :categories, through: :projects
  has_many :favorites, dependent: :destroy
  has_many :kids, dependent: :destroy
  has_many :user_certificates, dependent: :destroy
  has_many :certificates, through: :user_certificates

  scope :from_department, ->(department) { where('department_id = ?', department.id) }

  # rubocop:disable all
  scope :with_certificate,
    ->(certificate) { joins(:certificates).where('certificate_id = ?', certificate.id)}
  # rubocop:enable all

  scope :with_skill, ->(skill) { joins(:skills).where('skill_id = ?', skill.id) }

  # Certificate Expiry date
  attr_reader :expiry_date

  GENDER_TYPES = %w(- mann dame )
  def name
    "#{first_name} #{last_name}"
  end

  def full_last_name
    "#{last_name} #{first_name}".strip
  end

  def build_initials
    initials_v1 || initials_v2 || initials_v3
  end

  def initials_v1
    i = "#{normalize_name(first_name)[0] + normalize_name(last_name)[0, 3]}".upcase
    !User.where(initials: i).exists? ? i : nil
  end

  def initials_v2
    i = "#{normalize_name(first_name)[0, 2] + normalize_name(last_name)[0, 2]}".upcase
    !User.where(initials: i).exists? ? i : nil
  end

  def initials_v3
    i = "#{normalize_name(first_name)[0, 3] + normalize_name(last_name)[0, 1]}".upcase
    !User.where(initials: i).exists? ? i : nil
  end

  def normalize_name(name)
    name.parameterize.delete('-')
  end

  before_save :set_initials
  def set_initials
    self.initials ||= build_initials
  end

  def full_name
    "#{first_name} #{last_name}".strip
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
    now.year - birth_date.year
  end

  def self.with_role(role)
    User.all.select { |u| u.is? role }
  end

  def avatar
    image.url.present? ? image.url : "http://robohash.org/#{name}"
  end

  protected

  def send_devise_notification(notification, *args)
    if new_record? || changed?
      pending_notifications << [notification, args]
    else
      token = args.first
      reset_url = "#{edit_user_password_url(self,
                                            reset_password_token: token,
                                            host: ENV['DOMAIN'])}"
      Sms.send_msg(to: "47#{mobile}", msg: I18n.t('sms.reset', url: reset_url))
    end
  end

  def after_resetting_password_path_for
    root_path
  end
end
