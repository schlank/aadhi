class Notfound < ActiveRecord::Base
    
    after_update :flush_not_found_hash
	
	def self.find_notfound_requests(device_id)
		Rails.cache.fetch([:notfound, device_id]) do
			where(:device_id=>device_id)
        end
	end

	def flush_not_found_hash
		Rails.cache.delete([:notfound, device_id])
 	end

end
