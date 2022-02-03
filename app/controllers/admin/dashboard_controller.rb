class Admin::DashboardController < ApplicationController

  # http_basic_authenticate_with name: ENV['AUTH_USERNAME'].to_s, password: ENV['AUTH_PASSWORD'].to_s

  http_basic_authenticate_with name: "Jungle", password: "book"
  
  def show
    @products_count = Product.count(:all)
    @categories_count = Category.count(:all)
  end
end
