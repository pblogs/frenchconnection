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

  def users_with_profession(profession:)
    users.where(profession_id: profession.id)
  end

  def hours_spent_total(profession: nil)
    if profession
      @users = users_with_profession(profession: profession)
    else
      @users = users
    end
    sum = ''
    @users.each do |u|
      sum = hours_total_for(u)
    end
    sum
  end

  def hours_total_for(user)
    hours_spents.where(user_id: user.id).sum(:hour) +
    hours_spents.where(user_id: user.id).sum(:piecework_hours) +
    hours_spents.where(user_id: user.id).sum(:overtime_50) +
    hours_spents.where(user_id: user.id).sum(:overtime_100) 
  end

  def name_of_users(profession: nil)
    if profession
      u = users_with_profession(profession: profession)
      u.pluck(:first_name).join(', ')
    else
      users.pluck(:first_name).join(', ')
    end
  end

  def week_numbers
    w = hours_spents.collect { |h| h.created_at.to_datetime.cweek }
    w.uniq.sort!.join(', ')
  end

end
