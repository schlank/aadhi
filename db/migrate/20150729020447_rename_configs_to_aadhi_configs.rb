class Aadhiconfig < ActiveRecord::Base
end

class RenameConfigsToAadhiConfigs < ActiveRecord::Migration
  def change
      rename_table :configs, :aadhiconfigs
      # Reset ActiveRecord cache of Sync details
      Aadhiconfig.reset_column_information
      Aadhiconfig.create :server_mode=>"default"
  end
end
