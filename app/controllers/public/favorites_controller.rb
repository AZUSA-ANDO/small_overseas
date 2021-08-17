class Public::FavoritesController < ApplicationController

  before_action :authenticate_user!


  def create
    @spot = Spot.find(params[:spot_id])
    favorite = @spot.favorites.new(user_id: current_user.id)
    favorite.save

  end

  def destroy
    @spot = Spot.find(params[:spot_id])
    favorite = @spot.favorites.find_by(user_id: current_user.id)
    favorite.destroy

  end


end
