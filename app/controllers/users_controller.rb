class UsersController < ApplicationController
  before_action :authenticate_user!  

  def my_applications
    @publications = current_user.publications  
  end
  def update_resource(resource, params)
   
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    Rails.logger.debug "Storage: #{AvatarUploader.storage}"  
    resource.update_without_current_password(params)
  end
end
