class UsersController < ApplicationController
  before_filter :check_login,:except =>[:login, :create, :failure, :destroy]
  
  def upload_image
    if request.post?
#      render :text => params.inspect and return false
      add_or_upload = params[:add_or_upload]
      case add_or_upload
      when "add"
        render :partial => "/partials/add_pin", :layout => true
      when "upload"
        render :partial => "/partials/upload_pin", :layout => true
      end
    end
  end
  
  def login
    if params[:user]
      email = params[:user][:email]
      if email.nil? or email.blank?
        flash[:error] = "Hey, please enter valid email"
        return
      end
      user = User.find_or_create_by_email(email)
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Game on! Let’s play!"
    end
  end

  def create
    auth = request.env["rack.auth"]
#    render :text => auth.inspect and return false
    user = User.find_or_initialize_by_provider_and_uid(auth['provider'], auth['uid'])
    fb_info = user.fb_omni(auth)
    user.name = fb_info.name
    user.image_url= fb_info.picture
    if auth['credentials']
      user.remember_token = auth['credentials']['token']
      user.secret_token = auth['credentials']['secret']
    end
    user.save
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Start tagging now!"
  end
  
  def failure
    redirect_to root_url, :notice => "Authentication Failure"
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have ended your session."
    redirect_to root_url
  end
end
