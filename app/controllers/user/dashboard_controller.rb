class User::DashboardController < User::BaseController
  before_filter :authenticate_user!
  
  def index
    @recent_products = current_user.recent_products
    @recent_comments = current_user.recent_comments
  end
  
end
