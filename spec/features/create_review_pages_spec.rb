require 'rails_helper'

describe 'the create a review process' do
  before do
    @user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => @user.password
    click_on 'Log in'
    product = FactoryGirl.create(:product)
    visit product_path(product)
  end

  it 'will create a review' do
    fill_in 'Content', :with => 'This is a new review'
    click_on 'Create Review'
    expect(page).to have_content("#{@user.email} writes:")
  end

  it 'will fail to create a review' do
    click_on 'Create Review'
    expect(page).to_not have_content("#{@user.email} writes:")
  end
end
