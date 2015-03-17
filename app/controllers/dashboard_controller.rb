class DashboardController < UserApplicationController
  def index
    # @listings = @user.listings.select(Listing.default_select).where('posted_at > ?', 30.days.ago).order("posted_at DESC").paginate(page: params[:page], per_page: 20)
    @listings = @user.listings.select(Listing.default_select).where('posted_at > ?', 30.days.ago).order("posted_at DESC").paginate(page: params[:page], per_page: 20)
  end
end