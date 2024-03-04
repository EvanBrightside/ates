class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_enum(:task_statuses_list, %w[created done])
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, null: false, default: 0
      t.references :account, null: true, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
