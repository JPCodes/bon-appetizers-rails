class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index, :show]
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
  end

  def new
    @product = Product.new
    if user_signed_in?
      if !current_user.admin?
        flash[:warning] = 'You must have administrator privileges to see that page'
        redirect_to root_path
      end
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product Successfully Saved"
      redirect_to product_path(@product)
    else
      flash[:warning] = "Product Not Saved"
      render :new
    end
  end

  def edit
    if user_signed_in?
      if !current_user.admin?
        flash[:warning] = 'You must have administrator privileges to see that page'
        redirect_to root_path
      end
    end
  end

  def update
    if @product.update(product_params)
      flash[:success] = "Product Successfully Edited"
      redirect_to product_path(@product)
    else
      flash[:warning] = "Product Not Updated"
      render :edit
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product Deleted"
    redirect_to products_path
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
