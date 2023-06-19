# frozen_string_literal: true

class CarsController < ApplicationController
  before_action :set_car, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index search]

  # GET /cars
  def index
    save_params_to_session if given_params?
    SearchSaverService.call(search_params, current_user) if given_params? && current_user
    @cars = SearchService.call(search_params)
    sort_cars if params[:sort_by].present?
    @cars = @cars.page(params[:page])
  end

  def search; end

  # GET /cars/1
  def show; end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit; end

  # POST /cars
  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to car_url(@car), notice: t('.notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cars/1
  def update
    if @car.update(car_params)
      redirect_to car_url(@car), notice: t('.notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /cars/1
  def destroy
    @car.destroy

    redirect_to cars_url, notice: t('.notice')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def car_params
    params.require(:car).permit(:make, :model, :year, :odometer, :price, :description, :date_added)
  end

  def search_params
    params.permit(:make, :model, :year_from, :year_to, :price_from, :price_to)
  end

  def given_params?
    [params[:make], params[:model], params[:year_from], params[:year_to], params[:price_from], params[:price_to]]
      .any?(&:present?)
  end

  def save_params_to_session
    session[:previous_params] = params
  end

  def sort_cars
    if session[:previous_params].present?
      session[:previous_params] = session[:previous_params].transform_keys(&:to_sym)
      @cars = SearchService.call(session[:previous_params])
    end
    @cars = CarSortingService.call(@cars, params[:sort_by])
  end
end
