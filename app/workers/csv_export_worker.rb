require 'tempfile'

class CsvExportWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :default, :retry => true, :backtrace => true

  def perform(csv_export_id)
    csv_export = CsvExport.find csv_export_id
    csv_export.file = generate_file(csv_export)
    csv_export.file_name = "%s export on %s" % [csv_export.format_name.upcase, DateTime.now.strftime("%Y-%m-%d %H:%M")]
    csv_export.save!
  end

  private
  def generate_file(csv_export)
    file = Tempfile.new
    file.write(csv_export.user.shifts.to_csv(col_sep: col_sep(csv_export.format_name)))
    file.rewind
    file
  end
  def col_sep(format_name)
    case format_name.to_sym
    when :csv then CSV::DEFAULT_OPTIONS.fetch(:col_sep)
    when :xls then "\t"
    end
  end
end
