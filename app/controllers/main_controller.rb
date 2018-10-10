class MainController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @lists = {}
  end

  def send_mail
    mail = WeeklyMailer.weekly(current_user).deliver
    # render json: mail
    redirect_to '/'
  end

end
