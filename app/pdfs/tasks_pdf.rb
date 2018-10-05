class TasksPdf < Prawn::Document
  def initialize(list)
    super()
    @list = list
    tasks
  end

  def tasks
    text "#{@list.name}:", size: 18, style: :bold
    text "#{@list.description}", size: 12, style: :italic
    @list.tasks.each do |task|
      text "#{task.name}: #{task.done ? 'done' : 'pending'}", size: 15
    end
  end

end