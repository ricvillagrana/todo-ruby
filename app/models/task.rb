class Task < ApplicationRecord
  belongs_to :list

  def self.to_csv
    taskAttributes = %w{id list_id name done}

    CSV.generate(headers: true) do |csv|
      csv << taskAttributes
      all.each do |task|
        csv << taskAttributes.map do |taskAttr|
          task.send(taskAttr)
        end
      end
    end
  end
end
