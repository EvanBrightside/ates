class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.integer :status, null: false, default: 0
      t.text :description

      t.timestamps null: false
    end
  end
end
