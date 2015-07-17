# == Schema Information
#
# Table name: kids
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  birth_date   :date
#  sole_custody :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Kid < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true
  validates :user, presence: true
  validates :birth_date, presence: true

  def age
    now = Time.now.utc.to_date
    now.year - birth_date.year - (birth_date.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end
