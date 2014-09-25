class UsersController < ApplicationController
  include GinaAuthentication::Users
  load_and_authorize_resource
end
