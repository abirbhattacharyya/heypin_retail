class HomeController < ApplicationController
#  before_filter :check_login
  
  def index
    user_id = params[:user_id]
    query = ((user_id.to_i > 0) ? "user_id = #{user_id}" : nil)
    
    @pin_images = PinItem.find(:all,:conditions => ["#{query}"],:include => [:comments, :user],:order => "created_at desc")
    if current_user
      redirect_to addpin_path and return if @pin_images.empty?
      @like_pin_images = current_user.user_likes.map(&:pin_item_id)
    end    
    if query
      @user = User.find_by_id(user_id)
      if @pin_images.empty?
        flash[:notice] = "No data found!"
        redirect_to root_path
      end
    end
  rescue => e
    render :text => e.message
  end

  def search
    @search = params[:search]
    if @search.empty?
      redirect_to root_path
      return
    end
    @pin_images = PinItem.find(:all,:conditions => ["description like ?","%#{@search}%"],:include => [:comments, :user],:order => "created_at desc")
    if current_user
      @like_pin_images = current_user.user_likes.map(&:pin_item_id)
    end   
    render :action => :index
  end

  def winners
    @users = User.all.sort! { |u1, u2| u2.points <=> u1.points}
  end
end
