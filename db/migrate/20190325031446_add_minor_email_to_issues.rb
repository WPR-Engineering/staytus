class AddMinorEmailToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :minor_email, :boolean
  end
end
