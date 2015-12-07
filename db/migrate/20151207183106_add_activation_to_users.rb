class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false #migration for account activation (with added index)
    add_column :users, :activated_at, :datetime
  end
end
