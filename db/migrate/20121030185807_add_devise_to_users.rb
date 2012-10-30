class AddDeviseToUsers < ActiveRecord::Migration
  def self.change
    change_table(:users) do |t|
      t.string :username,           :null => false, :default => ""
    end

    add_index :users, :username,                :unique => true
  end
end
