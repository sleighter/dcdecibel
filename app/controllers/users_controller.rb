class UsersController < ApplicationController
  # POST /users/new
  # POST /users/new.json
  # POST /bands
  # POST /bands.json
  def create
    @user = User.new(params[:user])
    if @user.save
      render :json => @user
    else
      render :json => { :status => "fail" }
    end
  end
end
