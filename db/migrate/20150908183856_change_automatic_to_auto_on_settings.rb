class ChangeAutomaticToAutoOnSettings < ActiveRecord::Migration
  def change
    change_column :settings, :project_numbers, :string, default: 'auto'
  end
end
