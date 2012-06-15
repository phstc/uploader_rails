require 'spec_helper'

describe 'Buttons navigations' do
  
  it 'should visit New Upload and Cancel' do
    visit root_path
    click_link 'New Upload'
    page.should have_content 'Uploads / New'
    click_link 'Cancel'
    page.should have_content 'Uploads / All'
  end
  
  it 'should visit Show and Back' do
    upload = Factory :upload
    visit root_path
    click_link "#{upload.id}"
    page.should have_content "Uploads / ##{upload.id}"
    click_link 'Back'
    page.should have_content 'Uploads / All'
  end
end