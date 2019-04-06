class AddEmailListsToMaintenance < ActiveRecord::Migration
  def change
    add_column :maintenances, :low_risk_email, :boolean
    add_column :maintenances, :medium_risk_email, :boolean
    add_column :maintenances, :high_risk_email, :boolean
  end
end
