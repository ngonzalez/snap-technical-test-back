class Api::V1::CsvExportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_csv_export, only: [:show, :destroy]
  before_action :create_csv_export, only: [:create]

  def index
    @csv_exports = current_user.csv_exports.order(created_at: :desc).all
  end

  def show
    if authorized?
      send_data File.read(@csv_export.file.path),
        :type => "text/csv; charset=utf-8; header=present",
        :disposition => "attachment; filename=#{csv_file_name}"
    else
      handle_unauthorized
    end
  end

  def create
    if authorized?
      respond_to do |format|
        if @csv_export.persisted?
          format.json { render :show, status: :created, location: api_v1_csv_export_path(@csv_export) }
        else
          format.json { render json: @csv_export.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end
  end

  def destroy
    if authorized?
      @csv_export.destroy

      respond_to do |format|
        format.json { head :no_content }
      end
    else
      handle_unauthorized
    end
  end

  private

  def set_csv_export
    @csv_export = CsvExport.find(params[:id])
  end

  def create_csv_export
    @csv_export = current_user.csv_exports.new(csv_export_params)
    if @csv_export.save
      CsvExportWorker.perform_async(@csv_export.id)
    end
  end

  def authorized?
     @csv_export.user == current_user
  end

  def handle_unauthorized
    unless authorized?
      respond_to do |format|
        format.json { render :unauthorized, status: 401 }
      end
    end
  end

  def csv_export_params
    params.require(:csv_export).permit(:format_name)
  end

  def csv_file_name
    "%s.%s" % [@csv_export.file.name, params[:format]]
  end
end