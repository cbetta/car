class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :auth_token
      t.datetime :auth_at
      t.string :uid
      t.string :name
      t.string :provider
      t.boolean :access, default: false
      t.string :email

      t.timestamps
    end
  end
end
