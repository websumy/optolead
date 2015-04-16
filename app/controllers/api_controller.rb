class ApiController < ActionController::Base
  acts_as_jwt_authentication_handler
  before_filter :jwt_authenticate_user!
end