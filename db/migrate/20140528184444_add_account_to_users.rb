class AddAccountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :integer

    reversible do
      initial_account = Account.create(name: 'Initial Account')
      User.all.find_each { |user| user.update_column(:account_id, initial_account.id) }
    end
  end
end
