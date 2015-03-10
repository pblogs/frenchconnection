class HoursSpentPolicy  < ApplicationPolicy
  attr_reader :user, :hours_spent

  def initialize(user, hours_spent)
    @user = user
    @hours_spent = hours_spent
  end

  def index?
    true
  end

  def update?
    return false if hours_spent.approved?
    hours_spent.personal? && hours_spent.user == user  ||
    hours_spent.billable? && user.is?(:project_leader)
  end

  def edit?
    return false if hours_spent.approved?
    hours_spent.personal? && hours_spent.user == user  ||
    hours_spent.billable? && user.is?(:project_leader)
  end

  def destroy?
    return false if hours_spent.approved?
    hours_spent.personal? && hours_spent.user == user  ||
    hours_spent.billable? && user.is?(:project_leader)
  end

  def approve?
    user.is?(:project_leader)
  end

  def show?
    true
  end

  def create?
    true
  end

  def billable_hours?
    hours_spent.user == user
  end

  def personal_hours?
    true
  end


end
