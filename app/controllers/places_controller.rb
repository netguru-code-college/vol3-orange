class PlacesController < ApplicationController
  before_action :set_trip
  before_action :set_place, only: [:show, :edit, :update, :destroy]
  decorates_assigned :place, :transports, :attractions, :hotels

  def new
    @place = @trip.places.build
    @place.attractions.build
    @place.hotels.build
    @place.transports.build
  end

  def create
    @place = @trip.places.build(place_params)
    if @place.save
      redirect_to trip_path(@trip)
    else
      render :new
    end
  end

  def show
    @transports = @place.transports
    @hotels = @place.hotels
    @attractions = @place.attractions
  end

  def update
    if @place.update(place_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
    @place.destroy
    redirect_to trip_path(@trip)
  end

  private

  def place_params
    params.require(:place).permit(:name, :start_date, :end_date, :country)
  end

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def set_place
    @place = @trip.places.find(params[:id])
  end

end
