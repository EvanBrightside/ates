class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.decimal :balance
      t.string :currency
      t.references :account, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
