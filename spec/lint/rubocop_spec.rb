require 'spec_helper'

describe 'Check that the files we have changed have correct syntax' do
  before do
    current_sha = `git rev-parse --verify HEAD`.strip!
    files = `git diff master #{current_sha} --name-only | grep .rb`
    files.gsub!("\n", ' ')
    puts "Change files: #{files}"

    @report = `rubocop #{files}`
    puts "Report: #{@report}"
  end

  it { @report.match('Offenses').should be false }
end
