require 'rails_helper'

describe 'the edit a product process' do
  before do
    @user = FactoryGirl.create(:user)
    @product = FactoryGirl.create(:product)
    @user.admin = true
    @user.save
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_on 'Log in'
  end

  it 'will edit a product' do
    click_on 'Our Products'
    click_on 'Edit Product Listing'
    fill_in 'Title', :with => 'Not Chocolate Cake'
    click_on 'Submit and Upload'
    expect(page).to have_content('Not Chocolate Cake')
  end

  it 'will fail to edit a product due to incorrect form response' do
    click_on 'Our Products'
    click_on 'Edit Product Listing'
    fill_in 'Title', :with => ''
    click_on 'Submit and Upload'
    expect(page).to have_content('errors')
  end

  it 'will fail to edit a product due to not being admin' do
    @user.admin = false
    @user.save
    click_on 'Our Products'
    visit edit_product_path(@product)
    expect(page).to have_content('You must have administrator privileges to see that page')
  end
end
