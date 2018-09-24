class HotelsController < ApplicationController
  before_action :set_trip, :set_place
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]

  def new
    @hotel = @place.hotels.build
  end

  def create
    @hotel = @place.hotels.build(hotel_params)
    if @hotel.save
      redirect_to trip_place_path(@trip, @place)
    else
      render :new
    end
  end

  def update
    if @hotel.update(hotel_params)
      redirect_to trip_place_path(@trip, @place)
    else
      render :edit
    end
  end

  def destroy
    @hotel.destroy
    redirect_to trip_place_path(@trip, @place)
  end

  private

  def hotel_params
    params.require(:hotel).permit(
      :name,
      :address,
      :cost,
      :start_date,
      :end_date
    )
  end

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def set_place
    @place = @trip.places.find(params[:place_id])
  end

  def set_hotel
    @hotel = @place.hotels.find(params[:id])
  end

end
