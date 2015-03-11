class UserApplicationController < ApplicationController
  layout "user"
  before_action :authenticate_user!, :initialize_user

  private
  def initialize_user
    @user = current_user
  end
end