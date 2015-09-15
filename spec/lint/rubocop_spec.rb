require 'spec_helper'

describe 'Check that the files we have changed have correct syntax' do
  before do
    current_sha = `git rev-parse --verify HEAD`.strip!
    token = '316129065b398bed3730ce243b6f0f508354221e'
    url = 'https://api.github.com/repos/orwapp/orwapp/compare/' \
          "master...#{current_sha}?access_token=#{token}"
    files = `curl -i #{url} | grep filename | cut -f2 -d: | grep \.rb | tr '"', '\ '`
    files.tr!("\n", ' ')
    files.gsub!('Gemfile', '')
    files.gsub!('Gemfile.lock', '')
    cleaned = remove_missing_files(files)
    @report = 'nada'
    if cleaned.present?
      puts "Changed files: #{cleaned}"

      @report = `rubocop #{cleaned}`
      puts "Report: #{@report}"
    end
  end

  it { expect(@report.match('Offenses')).to be_falsey }

  def remove_missing_files(files)
    cleaned = []
    files.split.each do |file|
      next              unless File.exist? file
      cleaned << file
    end
    cleaned.join(' ')
  end
end
