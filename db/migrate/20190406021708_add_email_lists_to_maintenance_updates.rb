class AddEmailListsToMaintenanceUpdates < ActiveRecord::Migration
  def change
    add_column :maintenance_updates, :low_risk_email, :boolean
    add_column :maintenance_updates, :medium_risk_email, :boolean
    add_column :maintenance_updates, :high_risk_email, :boolean
  end
end
