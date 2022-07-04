require 'tempfile'

class CsvExportWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform csv_export_id, format_name
    csv_export = CsvExport.find csv_export_id
    col_sep = [:csv].include?(format_name) ? CSV::DEFAULT_OPTIONS.fetch(:col_sep) : "\t"
    file = Tempfile.new
    file.write csv_export.user.shifts.to_csv(col_sep: col_sep)
    file.rewind
    csv_export.file = file
    csv_export.file_name = "Export on %s" % Date.today.to_fs(:long)
    csv_export.save!
  end
end
