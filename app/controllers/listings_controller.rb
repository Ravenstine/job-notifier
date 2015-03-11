class ListingsController < UserApplicationController
  def show
    @listing = @user.listings.find(params[:id]) 
  end
end