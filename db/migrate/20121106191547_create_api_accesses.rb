class CreateApiAccesses < ActiveRecord::Migration
  def change
    create_table :api_accesses do |t|

      t.timestamps
    end
  end
end
