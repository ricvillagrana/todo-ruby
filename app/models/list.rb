class List < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(id: :asc) }

  def self.to_csv
    listAttributes = %w{id name description}

    CSV.generate(headers: true) do |csv|
      csv << listAttributes
      all.each do |list|
        csv << listAttributes.map do |listAttr|
          list.send(listAttr)
        end
      end
    end
  end

  def self.to_csv_with_tasks
    listAttributes = %w{id name description}
    taskAttributes = %w{id name done}

    CSV.generate(headers: true) do |csv|
      all.each do |list|
        csv << ['<<LIST>>']
        csv << listAttributes
        csv << listAttributes.map do |listAttr|
          list.send(listAttr)
        end
        csv << ['<<TASKS>>']
        csv << taskAttributes
        list.tasks.each do |task|
          csv << taskAttributes.map do |taskAttr|
            task.send(taskAttr)
          end
        end
      end
    end
  end
end
