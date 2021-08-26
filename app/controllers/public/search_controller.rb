class Public::SearchController < ApplicationController


  def search
    @overseas_areas = OverseasArea.all
    @value = params["value"] #Value = overseas_area.id
    @datas = match(@value).order(created_at: :desc).page(params[:page]).per(20)
    @overseas_area = OverseasArea.find(@value)
  end



  private
  def match(value)
    Spot.where(overseas_area_id: value)
  end



end
