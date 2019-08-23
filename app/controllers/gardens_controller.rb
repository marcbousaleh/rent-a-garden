class GardensController < ApplicationController
  before_action :set_garden, only: %i[show edit update destroy]

  def index
    @gardens = policy_scope(Garden)
    authorize @gardens

    if params[:query].present?
      search_map_garden
    else
      map_garden
    end
  end

  def show
    @markers = [
      {
        lat: @garden.latitude,
        lng: @garden.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { garden: @garden }),
        image_url: helpers.asset_url('seedling-solid.svg')
      }
    ]

    @review = Review.new
    authorize @review
  end

  def my_gardens
    @gardens = policy_scope(Garden).where(owner: current_user)
    authorize @gardens
  end

  def new
    @garden = Garden.new
    authorize @garden
  end

  def create
    @garden = Garden.new(garden_params)
    @garden.owner = current_user
    authorize @garden
    if @garden.save
      redirect_to garden_path(@garden)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @garden.update(garden_params)
    redirect_to garden_path(@garden)
  end

  def destroy
    @garden.destroy
    redirect_to gardens_path
  end

  private

  def map_garden
    @mapgardens = Garden.geocoded

    @markers = @mapgardens.map do |garden|
      {
        lat: garden.latitude,
        lng: garden.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { garden: garden }),
        image_url: helpers.asset_url('seedling-solid.svg')
      }
    end
  end

  def search_map_garden
    @mapgardens = Garden.search_by_address_and_title(params[:query])
    @markers = @mapgardens.map do |garden|
      {
        lat: garden.latitude,
        lng: garden.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { garden: garden }),
        image_url: helpers.asset_url('seedling-solid.svg')
      }
    end
  end

  def set_garden
    @garden = Garden.find(params[:id])
    authorize @garden
  end

  def garden_params
    params.require(:garden).permit(:price, :capacity, :address, :description, :title, :photo)
  end
end
