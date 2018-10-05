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
end
