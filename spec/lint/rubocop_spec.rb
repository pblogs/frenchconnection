require 'spec_helper'

describe 'Check that the files we have changed have correct syntax' do
  before do
    current_sha = `git rev-parse --verify HEAD`.strip!
    token = '316129065b398bed3730ce243b6f0f508354221e'
    url = 'https://api.github.com/repos/orwapp/orwapp/compare/' \
          "master...#{current_sha}?access_token=#{token}"
    files = `curl -i #{url} | grep filename | cut -f2 -d: | grep \.rb | tr '"', '\ '`
    files.tr!("\n", ' ')
    files.gsub!('db/schema.rb', '')
<<<<<<< HEAD
    @report = 'nada'
    if files.present?
      puts "Changed files: #{files}"
=======
    files.gsub!('Gemfile', '')
    files.gsub!('Gemfile.lock', '')
    cleaned = remove_missing_files(files)
    @report = ''
    @report = `rubocop #{cleaned}` if cleaned.present?
    puts "Rubocop report: #{@report}"
  end

  it { expect(@report.match('Offenses')).to be_falsey }
>>>>>>> 3244ef5... Output report

      @report = `rubocop #{files}`
      puts "Report: #{@report}"
    end
  end

  it { expect(@report.match('Offenses')).to be_falsey }
end
