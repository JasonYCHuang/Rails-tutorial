class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
  end

  protected    #redirect to show after edit user profile
    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      user_path(resource)
    end
  
end