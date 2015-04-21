# == Schema Information
#
# Table name: blog_projects
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  locale       :string
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
