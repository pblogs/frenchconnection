require 'spec_helper'

describe Inventory do
  let(:buldoze_driver) { Fabricate(:certificate, title: 'Bulldoze Driver')  }
  let(:bulldozer) { Fabricate(:inventory, name: 'Big Cat', 
                              certificates: [buldoze_driver]) }

  it 'is valid from the fabric' do
    Fabricate(:inventory).should be_valid
  end

  it 'requires sertificates' do
    bulldozer.certificates.should eq [buldoze_driver]
  end
end
