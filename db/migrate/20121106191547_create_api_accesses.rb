class CreateApiAccesses < ActiveRecord::Migration
  def change
    create_table :api_accesses do |t|
      t.integer  :user_id
      t.string   :application_name
      t.string   :access_token
      t.timestamps
    end
  end
end
