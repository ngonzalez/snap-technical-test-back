class Api::V1::ShiftsController < ApplicationController
  def index
  end

  def create
  end

  def update
  end

  def destroy
  end

  def bulk_create
    request.params[:shifts].each do |shift_params|
      Shift.create(shift_params)
    end

    head :ok
  end
end
