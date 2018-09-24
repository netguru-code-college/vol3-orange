class TripsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  decorates_assigned :trip, :trips, :current_trips, :upcoming_trips, :past_trips, :places

  def index
     if current_user
        @trips = current_user.trips
        @current_trips = @trips.current
        @upcoming_trips = @trips.upcoming
        @past_trips = @trips.past
    else
      @trips = nil
    end
  end

  def new
    @trip = current_user.trips.build
  end

  def create
    @trip = current_user.trips.build(trip_params)
    @trip.user_trips.new(user: current_user, role: 'owner')
    if @trip.save
      flash[:success] = "You have created the #{@trip.name}"
      redirect_to @trip
    else
      flash[:error] = "Please check the error, something wrong with your input."
      render :new
    end
  end

  def show
    @places = @trip.places.order("start_date asc")
  end

  def update
    if @trip.update(trip_params)
      redirect_to @trip
    else
      render :edit
    end
  end

  def destroy
    @trip.destroy
    redirect_to trips_path
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :image)
  end

  def set_trip
    @trip = current_user.trips.find(params[:id])
  end

end
