require 'spec_helper'

describe BlogVideo do
  before do
    @blog_video = Fabricate(:blog_video)
  end

  it 'is valid from the fabric' do
    expect(@blog_video).to be_valid
  end
end
