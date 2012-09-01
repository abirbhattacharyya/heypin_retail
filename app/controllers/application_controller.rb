# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'nokogiri'
require 'open-uri'
require "image_size"

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  # protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem
  include ApplicationHelper
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  def check_login
    unless logged_in?
      flash[:notice] = "Please login."
      redirect_to login_path
    end
  end

  def check_emails(emails)
    return false if emails.blank?
    return false if emails.gsub(',','').blank?
    emails.split(',').each do |email|
        unless email.strip =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/
          return false
        end
    end
    return true
  end
end
