class CreateAuthIdentities < ActiveRecord::Migration[7.0]
  def change
    enable_extension "plpgsql"

    create_enum "auth_identity_providers", %w[auth]
    create_table :auth_identities do |t|
      t.string :uid
      t.string :provider, null: false
      t.string :login, null: false
      t.string :token
      t.string :password_hash
      t.references :account, null: false, foreign_key: false

      t.timestamps null: false
    end

    add_foreign_key :auth_identities, :accounts, on_delete: :cascade
  end
end
