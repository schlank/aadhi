
class Device < ActiveRecord::Base
  belongs_to :scenario

    def find_route(get_path_query, method)
      logger.fatal "find_route.scenario_id: " + :scenario=>scenario_name
   		Rails.cache.fetch([:scenario, scenario_id, get_path_query, method]) do
    	 	route = scenario.routes.find_by(:path=>get_path_query, :route_type=>method)
     	end
    end
end
