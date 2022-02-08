require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    it 'should create a user if password confirmation is true' do
      @user = User.new(
        firstname:  'first_name', 
        lastname:  'last_name', 
        email: 'test@jungle.com',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect(@user.authenticate('Password!1')).to be_valid
    end

    it 'should not create a user if password confirmation is false' do
      @user = User.new(
        firstname:  'first_name', 
        lastname:  'last_name', 
        email: 'test@jungle.com',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect(@user.authenticate('Pass!1')).to be_falsey
    end

    it 'should not allow email to be case sensitive' do
      @user = User.new(
        firstname:  'first_name', 
        lastname:  'last_name', 
        email: 'test@test.COM',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect('TEST@TEST.com').not_to equal(@user.email)
    end

    it 'should not create user without email' do
      @user = User.new(
        firstname:  'first_name', 
        lastname:  'last_name', 
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      @user.valid?
      expect(@user.errors[:email]).to include("can\'t be blank")
    end

    it 'should not create user without firstname' do
      @user = User.new(
        lastname:  'last_name', 
        email: 'test@test.COM',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      @user.valid?
      expect(@user.errors[:firstname]).to include("can\'t be blank")
    end

    it 'should not create user without lastname' do
      @user = User.new(
        firstname:  'first_name',           
        email: 'test@test.COM',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      @user.valid?
      expect(@user.errors[:lastname]).to include("can\'t be blank")
    end

    it 'should not allow password length < 10' do
      @user = User.new(
        firstname:  'first_name',           
        email: 'test@test.COM',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect(@user.password.length).to be >= 10
    end
    
  end
  
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it 'allow user to login when there are spaces before or after the email address' do
      @user = User.new(
        firstname:  'first_name',           
        email: 'example@domain.com',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect(' example@domain.com').eql?(@user.email)
    end

    it 'allow user to login wrong case for their email address' do
      @user = User.new(
        firstname:  'first_name',           
        email: 'eXample@domain.COM',
        password: 'Password!1',
        password_confirmation: 'Password!1'  
      )          
      expect('EXAMPLe@DOMAIN.CoM').eql?(@user.email)
    end

  end
    
  
end      