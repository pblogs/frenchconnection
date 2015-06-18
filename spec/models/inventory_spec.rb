# == Schema Information
#
# Table name: inventories
#
#  id                               :integer          not null, primary key
#  name                             :string(255)
#  description                      :string(255)
#  certificates_id                  :integer
#  can_be_rented_by_other_companies :boolean          default(FALSE)
#  rental_price_pr_day              :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

require 'spec_helper'

describe Inventory do
  let(:task) { Fabricate(:task)  }
  let(:buldoze_driver) { Fabricate(:certificate, title: 'Bulldoze Driver')  }
  let(:bulldozer) { Fabricate(:inventory, name: 'Big Cat', 
                              certificates: [buldoze_driver]) }

  it 'is valid from the fabric' do
    Fabricate(:inventory).should be_valid
  end

  it 'requires sertificates' do
    bulldozer.certificates.should eq [buldoze_driver]
  end

  it 'belongs to a task that requires it to get the job done' do
    task.inventories = [bulldozer]
    task.inventories.first.should eq bulldozer
  end

end
