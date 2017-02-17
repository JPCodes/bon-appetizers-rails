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
      flash[:warning] = 'Review Not Saved'
      render :new
    end
  end

  def edit
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @user = User.find(@review.user_id)
  end

  def update
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @user = User.find(@review.user_id)
    if @review.update(review_params)
      flash[:success] = 'Review Successfully Updated'
      redirect_to product_path(@product)
    else
      flash[:warning] = 'Review Not Updated'
      redirect_to product_path(@product)
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    flash[:success] = 'Successfully Deleted Review'
    redirect_to product_path(@product)
  end

  private
  def review_params
    params.require(:review).permit(:content, :user_id)
  end
end
