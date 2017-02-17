require 'rails_helper'

describe 'the create a product process' do
  before do
    user = FactoryGirl.create(:user)
    user.admin = true
    user.save
    visit new_user_session_path
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_on 'Log in'
  end

  it 'will create a product' do
    click_on 'Add a Product'
    attach_file 'Image', "#{Rails.root}/spec/fixtures/images/test_photo2.jpg"
    fill_in 'Title', :with => 'Chocolate Cake'
    fill_in 'Description', :with => 'Our most delicious chocolate cake'
    fill_in 'Price', :with => 85.50
    click_on 'Submit and Upload'
    expect(page).to have_content('Chocolate Cake')
  end

  it 'will fail to create a product' do
    click_on 'Add a Product'
    click_on 'Submit and Upload'
    expect(page).to have_content('errors')
  end
end
