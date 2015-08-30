# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string
#  address        :string
#  org_number     :string
#  contact_person :string
#  phone          :string
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string
#  email          :string
#

class Customer < ActiveRecord::Base
  include Favorable

  validates :name, presence: true

  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :favorites, as: :favorable
  after_save :create_default_project

  class << self
    def last_updated_at
      Customer.order(:updated_at).select(:id, :updated_at).last.try(:updated_at)
    end
  end

  private
  def create_default_project
    project = self.projects.new(
                                name: I18n.t('projects.default_project'),
                                default: true,
                                description:
                                  I18n.t('projects.default_project_description'),
                               )
    project.save!
  end


end
