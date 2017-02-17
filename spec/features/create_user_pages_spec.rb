require 'rails_helper'

describe 'the create a user process' do
  it 'will create a user' do
    visit new_user_registration_path
    fill_in 'Email', :with => 'anon@site.com'
    fill_in 'Password', :with => '123456'
    fill_in 'Password confirmation', :with => '123456'
    click_button 'Sign up'
    click_link 'Logout'
    click_link 'Login'
    fill_in 'Email', :with => 'anon@site.com'
    fill_in 'Password', :with => '123456'
    click_on 'Log in'
    expect(page).to have_content('anon@site.com')
  end

  it 'will fail to create a user' do
    visit new_user_registration_path
    click_button 'Sign up'
    expect(page).to have_content('errors')
  end
end
