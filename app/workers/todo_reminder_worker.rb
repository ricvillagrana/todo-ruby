class TodoReminderWorker
  include Sidekiq::Worker

  def perform(*args)
    puts 'Sending emails'
    User.all.each do |user|
      puts "Sending to #{user.fullname}"
      WeeklyMailer.weekly(user).deliver
    end
  end
end
