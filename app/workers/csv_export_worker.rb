require 'tempfile'

class CsvExportWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform csv_export_id
    csv_export = CsvExport.find csv_export_id
    col_sep = [:csv].include?(csv_export.format_name) ? CSV::DEFAULT_OPTIONS.fetch(:col_sep) : "\t"
    file = Tempfile.new
    file.write csv_export.user.shifts.to_csv(col_sep: col_sep)
    file.rewind
    csv_export.file = file
    csv_export.file_name = "%s export on %s" % [csv_export.format_name.upcase, DateTime.now.strftime("%Y-%m-%d %H:%M")]
    csv_export.save!
  end
end
