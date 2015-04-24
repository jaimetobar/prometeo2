class CustomFailure < Devise::FailureApp


  def respond
    if http_auth?
      http_auth
    else
      store_location!
      flash[:alert] =  i18n_message(:invalid)
      redirect_to admin_root_path
    end
  end
end