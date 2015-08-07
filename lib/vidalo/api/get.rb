module Vidalo
  module API
    module Get
      # Return Nokogiri object
      def send_api_request(keyword, params = {})
        request = @conn.get do |req|
          req.url(keyword)
          unless params.empty?
            params.each do |param_key, param_value|
              req.params[param_key] = param_value
            end
          end
        end

        unless request.status == 200
          raise %{

            Seems there is a problem when connect to Vidal server. 
            The HTTP request status code is: #{request.status}.

            You may want to test the connection with the URL below in your browser:
            #{request.env.url}
          } 
        else
          Nokogiri::XML(request.body).errors.empty? ?
            Nokogiri::XML(request.body).remove_namespaces!.at('feed') :
            nil
        end
      end

      # Return number of total products
      def get_number_of_products
        send_api_request('products', { 'start-page' => 1, 'page-size' => 1 }).at('totalResults').text.to_i
      end
    end
  end
end
