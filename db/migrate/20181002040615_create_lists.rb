class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.references :user, foreign_key: true

      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
