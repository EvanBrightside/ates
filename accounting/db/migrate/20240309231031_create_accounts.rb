class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :email
      t.uuid   :public_id
      t.string :full_name
      t.string :role

      t.timestamps null: false
    end
  end
end
