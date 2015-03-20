class UserApplicationController < ApplicationController
  layout "user"
  before_action :authenticate_user!, :initialize_user, :initialize_listing_search

  private
  def initialize_listing_search
    @listing_search = params[:query] || ""
  end
  def initialize_user
    @user = current_user
  end
end