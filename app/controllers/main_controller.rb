class MainController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @lists = {}
  end

  def send_mail
    if WeeklyMailer.weekly(current_user).deliver
      render json: { status: 200, message: "Email sent successfully." }
    else
      render json: { status: 500, message: "Error sending the email." }
    end
  end

end
