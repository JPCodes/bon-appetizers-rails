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
      flash.now[:success] = "Product Successfully Saved"
      redirect_to product_path(@product)
    else
      flash.now[:warning] = "Product Not Saved"
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      flash.now[:success] = "Product Successfully Edited"
      redirect_to product_path(@product)
    else
      flash.now[:warning] = "Product Not Updated"
      render :edit
    end
  end

  private
  def product_params
    params.require(:product).permit(:title, :description, :price, :image)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
