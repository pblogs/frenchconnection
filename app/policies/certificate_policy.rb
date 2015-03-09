class CertificatePolicy  < ApplicationPolicy
  attr_reader :user, :certificate

  def initialize(user, certificate)
    @user = user
    @certificate = certificate
  end

  def index?
    true
  end

  def new?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def create?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def update?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def edit?
    user.is?(:project_leader) || user.is?(:admin)
  end

  def destroy?
    user.is?(:project_leader) || user.is?(:admin)
  end


  def show?
    true
  end



end
