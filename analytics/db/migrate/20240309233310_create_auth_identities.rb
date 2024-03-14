class CreateAuthIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :auth_identities do |t|

      t.timestamps
    end
  end
end
