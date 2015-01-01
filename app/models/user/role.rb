#
# Basically following the role based authorization approach explained by
# https://github.com/ryanb/cancan/wiki/Role-Based-Authorization
#
module User::Role
  extend ActiveSupport::Concern

  ROLES = [:admin, :project_leader, :worker]
  DEFAULT = :user

  included do
    before_save :default_role
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end
  
  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include? role.to_sym
  end


  private

  def default_role
    self.roles = [DEFAULT] if self.roles.blank?
  end
end
