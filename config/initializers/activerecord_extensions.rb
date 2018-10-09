require "addressable/uri"

module AadhiModelUtil

	def qs_to_hash(querystring)
		  keyvals = querystring.split('&').inject({}) do |result, q| 
		    k,v = q.split('=')
		    if !v.nil?
		       result.merge({k => v})
		    elsif !result.key?(k)
		      result.merge({k => ''})
		    else
		      result
		    end
		  end
		  keyvals
  end

  # Removed parameters that are generated or dynamic (but not required)
  # The urls with these params return 404 when they do not match a stub.
  def prune_query_parameters(path_with_query)
    logger.fatal "path_with_query: " + path_with_query.to_s
    # Localhost is just added as a placeholder.
    uri = Addressable::URI.parse("http://localhost"+path_with_query.to_s)
    if uri.query_values!=nil && uri.query_values!='' && !uri.query_values.blank?
      uri.query_values.delete("session_id")
      uri.query_values.delete("latitude")
      uri.query_values.delete("longitude")
      uri.query_values.delete("verifier")
      uri.query_values.delete("nearStoreNumbers")
      uri.query_values.delete("shopper_id")
      uri.query_values.delete("placement")
      uri.query_values.delete("bound")
      uri.query_values.delete("miles")
      uri = Addressable::URI.unencode(uri,Addressable::URI)
      uri.query_values["filterby"] = URI::encode(uri.query_values["filterby"])
      logger.fatal "uri.path+?+uri.query: " + uri.path+"?" + uri.query
      uri.path+"?"+uri.query
    else
      logger.fatal "no params uri.path: " + uri.path.to_s
      uri.path
    end
  end

	def sort_query_parameters(url)
    	temp_url = URI.parse(url)
    	query = temp_url.query
    	if query==nil || query=='' || query.blank?
    		path = temp_url.path
    	else
	    	path = temp_url.path
			hash_string = qs_to_hash(query)
			sorted_string =  Hash[hash_string.sort]
			final_sorted_string = sorted_string.to_query
			if final_sorted_string.to_s.strip.length != 0
				final_sorted_string = "?"<<final_sorted_string
			end
			path+URI.unescape(final_sorted_string)
		end
	end

end

ActiveRecord::Base.extend AadhiModelUtil