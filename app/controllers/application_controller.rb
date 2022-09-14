class ApplicationController < ActionController::Base
  before_action :authenticate_client!
  before_action :create_client_params, if: :devise_controller?


  private
  
  def create_client_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :cpf, :birth_date])
  end
end
