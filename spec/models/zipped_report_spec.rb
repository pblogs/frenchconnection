# == Schema Information
#
# Table name: zipped_reports
#
#  id          :integer          not null, primary key
#  project_id  :integer          not null
#  zipfile     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  report_type :string(255)
#

require 'spec_helper'

describe ZippedReport do
  describe "cleanup_old_reports" do

    before do
      @report = Fabricate :zipped_report
      @other_report = Fabricate :zipped_report
    end

    it "cleans up properly" do
      fresh_report = ZippedReport.create(
          project: @report.project, report_type: @report.report_type)
      expect { fresh_report.cleanup_old_reports }.to change(ZippedReport, :count).by(-1)
    end

  end
end
