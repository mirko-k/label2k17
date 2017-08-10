class ShipmentsController < ApplicationController

  # http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]

  def index
    @shipments = Shipment.order(:id)
  end

  def new
    @shipment = Shipment.new
    @shipment.address = Address.new
  end

  def edit
    @shipment = Shipment.find(params[:id])
  end

  def show
    @shipment = Shipment.find(params[:id])
  end

  def create
    @shipment = Shipment.new( shipment_params )
    @shipment.parcel_count.times do | number |
      @shipment.parcels.new( tracking_no: '1234' )
    end
    if @shipment.save
      flash[:notice] = 'Shipment was successfully created.'
      redirect_to @shipment
    else
      render 'new'
    end
  end

  def destroy
    @shipment = Shipment.find(params[:id])
    @shipment.destroy
    flash[:notice] = 'Shipment was successfully removed.'
    redirect_to shipments_path
  end

  def update
    @shipment = Shipment.find(params[:id])
    if @shipment.update(shipment_params)
      flash[:notice] = 'Shipment was successfully updated.'
      redirect_to shipments_path
    else
      render 'edit'
    end
  end

  private

  def shipment_params
    params.require(:shipment).permit(
      :hauler_id,:merchant_id,:cod_amount,:parcel_count,address_attributes:[
        :name_1,:name_2,:company_name,:additions,:street,:city,:zip_code,:country_id
      ]
    )
  end
end
