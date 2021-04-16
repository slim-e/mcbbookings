# frozen_string_literal: true

class RoomPaymentsController < ApplicationController
  before_action :set_room_payment, only: %i[show edit update destroy]

  # GET /room_payments or /room_payments.json
  def index
    @room_payments = RoomPayment.all
  end

  # GET /room_payments/1 or /room_payments/1.json
  def show; end

  # GET /room_payments/new
  def new
    @room_payment = RoomPayment.new
  end

  # GET /room_payments/1/edit
  def edit; end

  # POST /room_payments or /room_payments.json
  def create
    @room_payment = RoomPayment.new(room_payment_params)

    respond_to do |format|
      if @room_payment.save
        format.html { redirect_to @room_payment, notice: "Room payment was successfully created." }
        format.json { render :show, status: :created, location: @room_payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @room_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /room_payments/1 or /room_payments/1.json
  def update
    respond_to do |format|
      if @room_payment.update(room_payment_params)
        format.html { redirect_to @room_payment, notice: "Room payment was successfully updated." }
        format.json { render :show, status: :ok, location: @room_payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @room_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /room_payments/1 or /room_payments/1.json
  def destroy
    @room_payment.destroy
    respond_to do |format|
      format.html { redirect_to room_payments_url, notice: "Room payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room_payment
    @room_payment = RoomPayment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_payment_params
    params.require(:room_payment).permit(:payment_number, :status, :paid_at, :cost, :service, :booking_id, :user_id)
  end
end
