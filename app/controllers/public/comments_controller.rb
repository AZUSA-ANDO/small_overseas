class Public::CommentsController < ApplicationController

  before_action :authenticate_user!


  def create
		@spot = Spot.find(params[:spot_id])
		@comment = Comment.new(comment_params)
		@comment.spot_id = @spot.id
		@comment.user_id = current_user.id
		@spot.create_notification_comment!(current_user, @comment.id)
		unless @comment.save
		  render 'public/spots/show'
		end
  end

	def destroy
		@spot = Spot.find(params[:spot_id])
		@comment = @spot.comments.find(params[:id])
		@comment.destroy
	end


	private
	def comment_params
		params.require(:comment).permit(:opinion)
	end


end
