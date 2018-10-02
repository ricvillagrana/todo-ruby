class MainController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @lists = {}
  end

end
