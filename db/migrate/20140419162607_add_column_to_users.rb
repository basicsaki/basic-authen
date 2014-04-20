class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_auth_token, :string
  end
end
