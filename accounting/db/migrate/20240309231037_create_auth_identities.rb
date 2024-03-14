class CreateAuthIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_identities do |t|
      t.string :uid
      t.string :provider, null: false
      t.string :login, null: false
      t.string :token
      t.string :password_hash
      t.references :account, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps null: false
    end
  end
end
