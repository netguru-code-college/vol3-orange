class ChangeColumnTimeNameToDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :transports, :start_time, :start_date
    rename_column :transports, :end_time, :end_date
    rename_column :hotels, :start_time, :start_date
    rename_column :hotels, :end_time, :end_date
  end
end
