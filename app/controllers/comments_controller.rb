class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :current_entry

  def create
  	@comment = @entry.comments.build(comment_params)
    if @comment.save
      flash[:success] = "Comment Added!"
      # redirect_to :action => "show", :userid => params[:userid],:id => params[:id]
    	redirect_to user_entry_path
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def current_entry
    	@current_entry = Entry.find_by_id(params[:id])
    end
end