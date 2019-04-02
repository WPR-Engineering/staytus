class AddMinorEmailToIssueUpdates < ActiveRecord::Migration
  def change
    add_column :issue_updates, :minor_email, :boolean
  end
end
