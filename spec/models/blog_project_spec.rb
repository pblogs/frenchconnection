# == Schema Information
#
# Table name: blog_projects
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  image        :string(255)
#  locale       :string(255)
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe BlogProject do
  before do
    @blog_project = Fabricate(:blog_project)
  end

  it 'is valid from the fabric' do
    expect(@blog_project).to be_valid
  end
end
