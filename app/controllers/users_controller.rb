# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :set_room, only: [:new]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
    @client = Client.new
    @booking = Booking.new
    @room_payment = RoomPayment.new
    # @schedules = Schedule.where('start >= ? and start <=  ?', Date.today + 1.day, Date.today + 2.weeks).where(title: 'Available').order('start ASC').all
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    # create_client_charge
    # create_client_account

    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        create_client_profile
        create_client_booking
        create_client_room_payment
        # auto_login(@user)
        # UserMailer.new_signup_booking_admin(@user, @booking).deliver_later
        # UserMailer.new_signup_booking_client(@user, @booking).deliver_later

        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email)
  end

  def create_client_profile
    @client = Client.new
    @client.firstname = params[:user][:client][:firstname]
    @client.lastname = params[:user][:client][:lastname]
    @client.phone = params[:user][:client][:phone]
    @client.user_id = @user.id
    @client.save
  end

  def create_client_booking
    # Find automatically available room
    @room = Room.find(params[:user][:booking][:room_id])

    @booking = Booking.new
    @booking.room_id = params[:user][:booking][:room_id]
    @booking.schedule_id = params[:user][:booking][:schedule_id]
    @booking.client_id = @client.id
    @booking.title = @room.title
    @booking.cost = @room.cost
    @booking.status = "Booked"
    @booking.save
    # @schedule = Schedule.find(params[:user][:booking][:schedule_id])
    @booking.start = @schedule.start
    @booking.refunded = 0
    @booking.save

    # @schedule.title = 'Booked'
    # @schedule.save
  end

  def create_client_lesson_payment
    @room_payment = RoomPayment.new
    @room_payment.status = "Paid"
    @room_payment.date = Date.today
    @room_payment.cost = @room.cost
    # @room_payment.service = @room.title
    @room_payment.booking_id = @booking.id
    @room_payment.user_id = @user.user_id
    @room_payment.save
  end
end
