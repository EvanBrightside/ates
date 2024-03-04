class CreateTaskStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :task_statuses do |t|
      t.string :status, null: false
      t.string :comment
      t.references :account, null: false, foreign_key: true, on_delete: :cascade
      t.references :task, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
