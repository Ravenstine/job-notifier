class ListingsController < UserApplicationController
  def show
    @listing = @user.listings.select(Listing.default_select).find(params[:id]) 
    @listing.mark_read @user
  end
end