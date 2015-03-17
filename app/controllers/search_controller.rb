class SearchController < UserApplicationController
  def listings_search
    @listings = @user.listings.select(Listing.default_select).where("MATCH(title, description, contact_email) AGAINST (? IN NATURAL LANGUAGE MODE)", params[:query])
    render 'listings/search'
  end
end