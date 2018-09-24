class AttractionsController < ApplicationController
  before_action :set_trip, :set_place
  before_action :set_attraction, only: [:show, :edit, :update, :destroy]

  def index
    @attractions = @place.attractions
  end

  def new
    @attraction = @place.attractions.build
  end

  def create
    @attraction = @place.attractions.build(attraction_params)
    if @attraction.save
      redirect_to trip_place_path(@trip, @place)
    else
      render :new
    end
  end

  def edit ; end

  def update
    if @attraction.update(attraction_params)
      redirect_to trip_place_path(@trip, @place)
    else
      render :edit
    end
  end

  def destroy
    @attraction.destroy
    redirect_to trip_place_path(@trip, @place)
  end

  private

  def attraction_params
    params.require(:attraction).permit(
      :name,
      :start_date,
      :end_date,
      :cost
    )
  end

  def set_trip
    @trip = current_user.trips.find(params[:trip_id])
  end

  def set_place
    @place = @trip.places.find(params[:place_id])
  end

  def set_attraction
    @attraction = @place.attractions.find(params[:id])
  end

end
