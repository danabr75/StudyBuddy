class AddInvitableFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    ## Invitable
    add_column :users, :invitation_token, :string
    add_column :users, :invitation_created_at, :datetime
    add_column :users, :invitation_sent_at, :datetime
    add_column :users, :invitation_accepted_at, :datetime
    add_column :users, :invitation_limit, :integer
    add_column :users, :invited_by_type, :string
    add_column :users, :invited_by_id, :integer

    add_index :users, :invitation_token, unique: true
  end
end
