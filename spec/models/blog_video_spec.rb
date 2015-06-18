# == Schema Information
#
# Table name: blog_videos
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  video_url    :string(255)
#  locale       :string(255)
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
