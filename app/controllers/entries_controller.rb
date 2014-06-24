class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
  	@user = User.find_by_id(params[:userid])
  	@entry = Entry.find_by_id(params[:id])
  	@comments = @entry.comments.paginate(page: params[:page])
  	@comment = @entry.comments.build if signed_in?
  end

  def create
  	@entry = current_user.entries.build(entry_params)
    if @entry.save
    	flash[:success] = "Entry created!"
    	redirect_to root_url
    else
    	@feed_items = []
    	render 'static_pages/home'
    end
  end

  def destroy
  	@entry.destroy
    redirect_to root_url
  end

  private

  	def entry_params
    	params.require(:entry).permit(:title, :body)
	end

    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end

end