class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  before_action :set_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
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
