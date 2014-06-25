class AddRememberTokenToEntries < ActiveRecord::Migration
  def change
  	add_column :entries, :remember_token, :string
    add_index  :entries, :remember_token
  end
end
