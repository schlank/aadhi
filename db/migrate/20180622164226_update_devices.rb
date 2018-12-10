class UpdateDevices < ActiveRecord::Migration
  def change
    rename_column :devices, :device_ip, :device_id
    rename_column :device_reports, :device_ip, :device_id
    rename_column :notfounds, :device_ip, :device_id
  end
end