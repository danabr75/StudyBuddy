class AddInvitableFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    # ## Lockable
    # add_column :users, :failed_attempts, :integer, default: 0, null: false
    # add_column :users, :unlock_token, :string
    # add_column :users, :locked_at, :datetime

    ## Invitable
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invited_by_type, :string
    add_column :users, :invited_by_id, :integer

    add_index :users, :unlock_token, unique: true
    add_index :users, :invitation_token, unique: true
  end
end
