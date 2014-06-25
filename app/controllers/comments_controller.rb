class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]

  def create
  	@comment = current_entry.comments.build(comment_params)
    if @comment.save
      	flash[:success] = "Comment Added!"
      	# redirect_to :action => "show", :userid => params[:userid],:id => params[:id]
    	redirect_to entry_path(id: current_entry.id)
    else
    	flash.now[:error] = "Invalid content!"
      	redirect_to entry_path(id: current_entry.id)
    end
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

end