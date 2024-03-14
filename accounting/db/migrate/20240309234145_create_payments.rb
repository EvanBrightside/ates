class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.string :currency
      t.string :type
      t.references :task, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true
      t.references :wallet, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end