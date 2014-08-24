class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  require 'clickatell'

  ROLES = %w[admin leader project_leader worker economy]
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  belongs_to :department

  def has_role?(role)
    roles.include? role.to_s
  end

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :mobile,     presence: true, uniqueness: true

  # Worker
  has_and_belongs_to_many :tasks
  has_many :projects, :through => :tasks
  has_many :hours_spents

  def name
    "#{ first_name } #{ last_name }"
  end

  def self.workers
    User.where("'worker' = ANY (roles)")
  end

  def avatar
    filename = "users/#{ name.parameterize }.jpg"
    File.exist?(filename) ? filename : "http://robohash.org/#{name}"
  end
  
  def full_name
    "#{ first_name } #{ last_name }".strip
  end

  def full_name=(name)
    name = name.split(' ')
    self.last_name  = name.pop
    self.first_name = name.join(' ')
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
      SMS.send_message("47#{mobile}", msg, {:from=>"Orwapp"})
    end
  end

  def after_resetting_password_path_for(resource)
    root_path
  end
end
