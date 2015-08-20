# == Schema Information
#
# Table name: blog_videos
#
#  id           :integer          not null, primary key
#  title        :string
#  content      :text
#  video_url    :string
#  locale       :string
#  published    :boolean
#  publish_date :date
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe BlogVideo do
  before do
    @blog_video = Fabricate(:blog_video)
  end

  it 'is valid from the fabric' do
    expect(@blog_video).to be_valid
  end
end
