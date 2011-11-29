class AddBranchNameToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :git_branch_name, :string
  end
end
