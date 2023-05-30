class AddLockableFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :failed_attempts, :integer
    add_column :users, :unlocked_token, :string
    add_column :users, :locked_at, :datetime

    add_index :users, :unlock_token, unique: true
  end
end
