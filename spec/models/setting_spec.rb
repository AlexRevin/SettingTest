require File.dirname(__FILE__) + '/../spec_helper'

describe Setting do

  after(:all) do
    Setting.destroy_all
  end

  describe 'add variable' do
    Setting.email.should == nil
    Rails.cache.read('Setting_email').should == nil
    Setting.email = "test@test.com"
    Setting.email.should == "test@test.com"
    Rails.cache.read('Setting_email').should == "test@test.com"
  end

  describe 'show all variables' do
    vars = []
    vars <<  {"email" => "test@test.com"}
    vars <<  {"test" => true}
    Setting.test = true
    Setting.all.should == vars
  end

  describe 'show all variables by type' do
    vars = []
    vars <<  {"email" => "test@test.com"}
    Setting.test = true
    Setting.all('String').should == vars
  end

  describe 'destroty variable' do
    Setting.email.should == "test@test.com"
    Rails.cache.read('Setting_email').should == "test@test.com"
    Setting.destroy(:email).should == true
    Setting.email.should == nil
    Rails.cache.read('Setting_email').should == nil
  end

end