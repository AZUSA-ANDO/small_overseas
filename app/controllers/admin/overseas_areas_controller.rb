class Admin::OverseasAreasController < ApplicationController

  before_action :authenticate_admin!

  layout "admin"

  def index
    @overseas_area = OverseasArea.new
    @overseas_areas = OverseasArea.all
  end

  def edit
    @overseas_area = OverseasArea.find(params[:id])
  end

  def update
    overseas_area = OverseasArea.find(params[:id])
    overseas_area.update(overseas_area_params)
    redirect to admin_overseas_areas_path
  end

  def create
    @overseas_area = OverseasArea.new(overseas_area_params)
    @overseas_area.save
    flash[:notice] ="ジャンルを追加しました"
    redirect_to admin_overseas_areas_path
  end

   def destroy
     @overseas_area = OverseasArea.find(params[:id])
     @overseas_area.destroy
     redirect_to admin_overseas_areas_path
   end


  private
  def overseas_area_params
    params.require(:overseas_area).permit(:name,:spot_id)
  end


end
