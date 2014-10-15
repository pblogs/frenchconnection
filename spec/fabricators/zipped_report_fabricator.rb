Fabricator(:zipped_report) do
  project { Fabricate :project }
  report_type { ZippedReport.report_type_enum.shuffle.first.last }
end
