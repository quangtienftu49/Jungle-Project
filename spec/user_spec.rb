require "rails_helper"

RSpec.describe User, type: :model do

  describe 'Validations' do
    # These are required when creating the model so you should also have an example for this
    it "should be valid with all fields correct" do
      @user = User.new(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end
   
    it "should have a password and password_confirmation input" do
      @user = User.new(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: nil)
      expect(@user).not_to be_valid
    end

    # These need to match so you should have an example for where they are not the same
    it "should not be valid if password and password_confirmation do not match" do
      @user = User.new(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: "passwor")
      expect(@user).not_to be_valid
    end

    # Emails must be unique (not case sensitive)
    it "should not be valid if email already exists in db" do
      @user1 = User.create(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: "password")
      @user2 = User.new(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: "password")
      expect(@user2).not_to be_valid
    end

    # Email, first name, and last name should also be required
    it "should not be valid without email, first name, and last name" do
      @user = User.new(first_name: nil, last_name: nil, email: nil, password: "password", password_confirmation: "password")
      expect(@user).not_to be_valid
    end

    # The password must have a minimum length when a user account is being created.
    it "should not be valid with password of length less than 5" do
      @user = User.new(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "hi", password_confirmation: "hi")
      expect(@user).not_to be_valid
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "should be valid when email is in different cases" do
      @user = User.create(first_name: "Julia", last_name: "J", email: "PINEAPPLE@pineapple.com", password: "password", password_confirmation: "password")
      @user2 = User.authenticate_with_credentials("pineapple@PINEAPPLE.com", "password")
      expect(@user2).not_to be_nil
      expect(@user.id).to match(@user2.id)
    end

    it "should be valid when email is in different cases" do
      @user = User.create(first_name: "Julia", last_name: "J", email: "pineapple@pineapple.com", password: "password", password_confirmation: "password")
      @user2 = User.authenticate_with_credentials("pineapple@pineapple.com", "password")
      expect(@user2).not_to be_nil
      expect(@user.id).to match(@user2.id)
    end

    it "should be valid when email has spaces before/after" do
      @user = User.create(first_name: "Julia", last_name: "J", email: "  pineapple@pineapple.com", password: "password", password_confirmation: "password")
      @user2 = User.authenticate_with_credentials("pineapple@pineapple.com  ", "password")
      expect(@user2).not_to be_nil
      expect(@user.id).to match(@user2.id)
    end
  end

end