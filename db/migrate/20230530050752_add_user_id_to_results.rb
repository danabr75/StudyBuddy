class AddUserIdToResults < ActiveRecord::Migration[7.0]
  def change
    add_column :results, :user_id, :bigint
    add_index :results, :user_id
  end
end
