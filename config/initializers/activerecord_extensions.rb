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

  # def prune_query_parameters(path_with_query)
  #   logger.fatal "path_with_query: " + path_with_query.to_s
  #   # Localhost is just added as a placeholder.
  #   uri = Addressable::URI.parse("http://localhost"+path_with_query.to_s)
  #   params = uri.query_values
  #   if params!=nil && params!='' && !params.blank?
  #     params.delete("session_id")
  #     params.delete("latitude")
  #     params.delete("longitude")
  #     params.delete("verifier")
  #     params.delete("nearStoreNumbers")
  #     params.delete("shopper_id")
  #     params.delete("placement")
  #     params.delete("bound")
  #     params.delete("miles")
  #     uri.query_values = params
  #     logger.fatal "uri.path+?+uri.query: " + uri.path+"?" + URI.unescape(uri.query)
  #     uri.path+"?"+ URI.unescape(uri.query)
  #   else
  #     logger.fatal "no params uri.path: " + uri.path.to_s
  #     uri.path
  #   end
  # end

	def sort_query_parameters(url)
      # Addressable automatically sorts query params.
      uri = Addressable::URI.parse(url)
      params = uri.query_values

      # Removed parameters that are generated or dynamic (but not required)
      # The urls with these params return 404 when they do not match a stub.
      if params!=nil && params!='' && !params.blank?
        params.delete("session_id")
        params.delete("latitude")
        params.delete("longitude")
        params.delete("verifier")
        params.delete("nearStoreNumbers")
        params.delete("shopper_id")
        params.delete("placement")
        params.delete("bound")
        params.delete("miles")
        uri.query_values = params
        uri.path+"?"+ URI.unescape(uri.query)
      else
        logger.fatal "no params uri.path: " + uri.path.to_s
        uri.path
      end
	end

end

ActiveRecord::Base.extend AadhiModelUtil