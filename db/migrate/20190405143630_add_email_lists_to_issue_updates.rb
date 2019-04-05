class AddEmailListsToIssueUpdates < ActiveRecord::Migration
  def change
    add_column :issue_updates, :major_email, :boolean
    add_column :issue_updates, :critical_email, :boolean
  end
end
