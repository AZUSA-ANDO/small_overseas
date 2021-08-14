class Public::SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_overseas_areas, only: [:index, :show, :new, :edit, :create,:update, :destroy]

  def new
    @spot = Spot.new
    @overseas_areas = OverseasArea.all
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user_id = current_user.id
    if @spot.save
      redirect_to spot_path(@spot.id)
    else
      render action: :new
    end
  end

  def index
    # 新しい投稿が上に来るように
    @spots = Spot.all.order(created_at: :desc)
    @overseas_areas = OverseasArea.all
  end

  def show
    @spot = Spot.find(params[:id])
    @comment = Comment.new
    @overseas_areas = OverseasArea.all
  end


  def edit

  end

  def update
  if @spot.update(spot_params)
    redirect_to spot_path(@spot), notice: "You have updated spot successfully."
  else
    render action: :edit
  end
  end

   def destroy
     @spot.destroy
     redirect_to user_path(@spot.user_id)
   end

    def search
      @all_ranks = Spot.find(Favorite.group(:spot_id).order('count(spot_id) desc').limit(3).pluck(:spot_id))
      @spots = Spot.all
      @overseas_areas = OverseasArea.all
    end

  def rank
    # 週間ランキング
    @week_post_like_ranks = Spot.find(Favorite.group(:spot_id).where(created_at: Time.current.all_week).order('count(spot_id) desc').pluck(:spot_id))
  end


  private
  def spot_params
    params.require(:spot).permit(
      :user_id,
      :overseas_area_id,
      :name,
      :introduction,
      :address,
      :spot_image,
      :japan_area,
      )
  end


  def set_overseas_areas
    @overseas_areas = OverseasArea.all
  end



  def ensure_correct_user
    @spot = Spot.find(params[:id])
    unless @spot.user == current_user
      redirect_to spots_path
    end
  end


end
