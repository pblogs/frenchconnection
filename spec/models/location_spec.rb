# == Schema Information
#
# Table name: locations
#
#  id              :integer          not null, primary key
#  name            :string
#  certificates_id :integer
#  outdoor         :boolean
#  indoor          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Location do
  let(:roof_climber) { Fabricate(:certificate, title: 'Roof Climber') }
  let(:welder) { Fabricate(:certificate, title: 'Welder') }
  let(:location) { Fabricate(:location, name: 'Top of building', 
                             certificates: [roof_climber, welder]) }

  it 'has many certificates' do
    location.certificates.should eq [roof_climber, welder]
  end

end
