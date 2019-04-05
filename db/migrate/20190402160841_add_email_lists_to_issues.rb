class AddEmailListsToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :major_email, :boolean
    add_column :issues, :critical_email, :boolean
  end
end
