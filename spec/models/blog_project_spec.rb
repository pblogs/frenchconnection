require 'spec_helper'

describe BlogProject do
  before do
    @blog_project = Fabricate(:blog_project)
  end

  it 'is valid from the fabric' do
    expect(@blog_project).to be_valid
  end
end
