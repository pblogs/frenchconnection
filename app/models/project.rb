class Project < ActiveRecord::Base
  has_many :tasks
  has_many :attachments
  has_many :hours_spents, :through => :tasks
  has_many :users,        :through => :tasks

  belongs_to :customer
  belongs_to :user
  belongs_to :department

  validates :customer_id,    :presence => true
  validates :start_date,     :presence => true
  validates :due_date,       :presence => true
  validates :department_id,  :presence => true
  validates :project_number, :presence => true


  def professions
    professions = []
    users.each { |u| professions << u.profession }
    professions.uniq
  end

  def hours_spent_total
    hours_spents.sum(:hour) +
    hours_spents.sum(:piecework_hours) +
    hours_spents.sum(:overtime_50) +
    hours_spents.sum(:overtime_100) 
  end

  def hours_total_for(user)
    hours_spents.where(user_id: user.id).sum(:hour) +
    hours_spents.where(user_id: user.id).sum(:piecework_hours) +
    hours_spents.where(user_id: user.id).sum(:overtime_50) +
    hours_spents.where(user_id: user.id).sum(:overtime_100) 
  end

  def name_of_users(profession: nil)
    if profession
      u = users.where(profession_id: profession.id)
      u.pluck(:first_name).join(', ')
    else
      users.pluck(:first_name).join(', ')
    end
  end

end
