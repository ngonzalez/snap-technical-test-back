class Api::V1::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:show, :edit, :update, :destroy, :export]

  def index
    @shifts = current_user.shifts.order(start_at: :desc).all
  end

  def show
    if authorized?
      respond_to do |format|
        format.json { render :show }
      end
    else
      handle_unauthorized
    end
  end

  def create
    @shift = current_user.shifts.build(shift_params)

    if authorized?
      respond_to do |format|
        if @shift.save
          format.json { render :show, status: :created, location: api_v1_shift_path(@shift) }
        else
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end
  end

  def update
    if authorized?
      respond_to do |format|
        if @shift.update(shift_params)
          format.json { render :show, status: :ok, location: api_v1_shift_path(@shift) }
        else
          format.json { render json: @shift.errors, status: :unprocessable_entity }
        end
      end
    else
      handle_unauthorized
    end
  end

  def destroy
    if authorized?
      @shift.destroy

      respond_to do |format|
        format.json { head :no_content }
      end
    else
      handle_unauthorized
    end
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def authorized?
     @shift.user == current_user
  end

  def handle_unauthorized
    unless authorized?
      respond_to do |format|
        format.json { render :unauthorized, status: 401 }
      end
    end
  end

  def shift_params
    params.require(:shift).permit(:start_at, :end_at)
  end    
end
