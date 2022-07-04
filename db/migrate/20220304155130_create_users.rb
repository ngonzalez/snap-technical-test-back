class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    execute "CREATE TYPE user_roles AS ENUM ('%s');" % user_roles
    create_table :users do |t|
      # Database authenticatable
      t.string :email, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      # Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      # Rememberable
      t.datetime :remember_created_at

      # Role
      t.column :role, 'user_roles', null: false, default: user_roles_default

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
  end
  
  private
  def user_roles
    ['user','admin']
  end
  
  def user_roles_default
    'user'
  end
end
