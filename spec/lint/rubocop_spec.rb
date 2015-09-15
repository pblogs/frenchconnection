require 'spec_helper'

describe 'Rubocop checks that the files we have changed have correct syntax' do
  before do
    current_sha = `git rev-parse --verify HEAD`.strip!
    files = `git diff master #{current_sha} --name-only | grep .rb`
    files.tr!("\n", ' ')
    files.gsub!('db/schema.rb', '')
    files.gsub!('Gemfile', '')
    files.gsub!('Gemfile.lock', '')
    cleaned = remove_missing_files(files)
    @report = ''
    @report = `rubocop #{cleaned}` if cleaned.present?
    puts "Rubocop report: #{@report}"
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
