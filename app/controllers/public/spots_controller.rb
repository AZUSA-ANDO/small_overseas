class Public::SpotsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_overseas_areas

  def new
    @spot = Spot.new
    @spot.spot_images.new
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
    @spots = Spot.all.order(created_at: :desc).page(params[:page]).per(10)
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

# 月間ランキング
# Spotモデルから()内のデータを探す
# Favorite.group(:post_id)→Favotiteモデルのspot_idが同じものをまとめる
# where(created_at: Time.current.all_week)→投稿が作られた日が今月のデータのみ抽出
# order('count(spot_id) desc')→まとめたものをspot_idの多い順に並び替える
# pluck(:spot_id)→そのままだとFavoriteモデルで取り出してしまうので、post_idで値を取りだす
  def rank
    @month_post_like_ranks = Spot.find(Favorite.group(:spot_id).where(created_at: Time.current.all_month).order('count(spot_id) desc').limit(10).pluck(:spot_id))
  end

# お店の名前or住所で検索
  def search
    @search_spots = Spot.search(params[:key])
  end

# フォローしている人・自分の投稿一覧
  def home
    @spots = Spot.where(user_id: [current_user.id,*current_user.following_user]).order(created_at: :desc).page(params[:page]).per(10)
  end




  private
  def spot_params
    params.require(:spot).permit(
      :user_id,
      :overseas_area_id,
      :name,
      :introduction,
      :address,
      :japan_area,
      spot_images_images: [])
  end

# overseasの情報を取り込み
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
