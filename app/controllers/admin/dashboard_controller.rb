class Admin::DashboardController < ApplicationController

    
  def show
    @products = Product.all.count
    @category = Category.all.count
  end


end
