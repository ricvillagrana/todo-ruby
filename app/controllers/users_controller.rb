class UsersController < ApplicationController
  def view
    @user = current_user
  end

  def edit
    @user = current_user
  end
end
