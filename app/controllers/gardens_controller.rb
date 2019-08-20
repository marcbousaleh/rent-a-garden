class GardensController < ApplicationController
  def index
    @gardens = Garden.all
  end

  def new
    @garden = Garden.new
  end

  def create
    @garden = Garden.new(garden_params)
    if @garden.save
      redirect_to gardens_path
    else
      render :new
    end
  end

  def garden_params
    params.require(:garden).permit(:address, :description, :photo)
  end
end
