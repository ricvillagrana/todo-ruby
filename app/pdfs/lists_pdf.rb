class ListsPdf < Prawn::Document
  def initialize(user)
    super()
    @lists = user.lists
    @user = user
    user_info
    lists
  end

  def user_info
    text "Lists of #{@user.fullname}", size: 24, style: :bold
    text "Exported #{Date.today}", size: 12
  end

  def lists
    @lists.each do |list|
      text "#{list.name}:", size: 18, style: :bold
      text "#{list.description}", size: 12, style: :italic
      list.tasks.each do |task|
        text "#{task.name}: #{task.done ? 'done' : 'pending'}", size: 15
      end
    end
  end

end