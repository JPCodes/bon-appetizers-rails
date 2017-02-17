class ReviewsController < ApplicationController
  def new
    @product = Product.find(params[:id])
    @review = @product.reviews.new
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    if @review.save
      redirect_to product_path(@product)
    else
      flash[:warning] = 'Review not saved'
      render :new
    end
  end

  private
  def review_params
    params.require(:review).permit(:content, :user_id)
  end
end
