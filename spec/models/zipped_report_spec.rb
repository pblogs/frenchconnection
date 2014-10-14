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
