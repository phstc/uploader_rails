require 'spec_helper'

describe 'Upload process' do
  before :each do
    visit root_path
    click_link 'New Upload'
  end
  
  it 'should upload and show' do
    # path = File.join ::Rails.root, 'homer.jpg'
    # attach_file 'upload', path
    # fill_in 'upload_file_url', with: 'http://simpsons.com/homer.jpg'
    page.find('#upload_file_url').set('http://simpsons.com/homer.jpg')
    fill_in 'upload_description', with: 'Awesome description'
    click_button 'Create Upload'
    page.should have_content 'http://simpsons.com/homer.jpg'
    page.should have_content 'Awesome description'
  end

  it 'should not upload invalid data' do
    click_button 'Create Upload'
    page.should have_content 'File can\'t be blank'
    page.should have_content 'Description can\'t be blank'
  end
end