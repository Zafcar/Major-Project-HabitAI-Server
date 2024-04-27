class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    Devise::ParameterSanitizer::DEFAULT_PERMITTED_ATTRIBUTES[:sign_up] = %i[password name]
  end
end
