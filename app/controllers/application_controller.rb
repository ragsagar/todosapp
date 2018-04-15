class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # TODO: Enable basic auth.
  #include ActionController::HttpAuthentication::Basic::ControllerMethods
  #http_basic_authenticate_with name: "username", password: "password123"
end
