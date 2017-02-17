require 'rails_helper'

describe 'the edit a review process' do
  before do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on 'Log in'
    product = FactoryGirl.create(:product)
    review = FactoryGirl.create(:review, product_id: product.id, user_id: user.id)
    visit product_path(product)
  end

  it 'will edit a review' do
    click_on 'Manage Review'
    fill_in 'Content', :with => 'Awesome product'
    click_on 'Update Review'
    expect(page).to have_content("Review Successfully Updated")
  end

  it 'will fail to edit a review' do
    click_on 'Manage Review'
    fill_in 'Content', :with => ''
    click_on 'Update Review'
    expect(page).to have_content("Review Not Updated")
  end
end
