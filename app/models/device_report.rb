class DeviceReport < ActiveRecord::Base
	has_many:device_scenarios, dependent: :destroy
	def self.export_as_xml(device_id)
      	  @reports = DeviceReport.where(:device_id=>device_id).includes({:device_scenarios =>:scenario_routes}).joins({:device_scenarios =>:scenario_routes})
      	  @reports.to_xml(:include=>[:device_scenarios =>{:include=>[:scenario_routes=>{:only => [:path, :route_type, :count]}]}])
    end
end
