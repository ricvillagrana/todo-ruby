class WeeklyMailer < ApplicationMailer
  default from: 'ricardovillagranal@gmail.com'

  def weekly(user)
    @user = user
    mail(to: user.email, subject: 'Sample Email')
  end
end
