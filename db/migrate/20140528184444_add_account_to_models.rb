class AddAccountToModels < ActiveRecord::Migration
  def change
    add_column :users, :account_id, :integer
    add_column :projects, :account_id, :integer

    reversible do
      initial_account = Account.create(name: 'Initial Account')
      User.find_each { |user| user.update_column(:account_id, initial_account.id) }
      Project.find_each { |project| project.update_column(:account_id, initial_account.id) }
    end
  end
end
