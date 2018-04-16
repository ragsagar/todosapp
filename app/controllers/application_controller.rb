class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: "todoapp", password: "aymcommerce"
end
