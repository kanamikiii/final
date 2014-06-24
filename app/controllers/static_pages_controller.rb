class StaticPagesController < ApplicationController
  def home
  	if signed_in?
  		@entry = current_user.entries.build
  		@feed_items = current_user.feed.paginate(page: params[:page])
  	end
  end

  def contact
  end

  def comment  	
  end
  
end
