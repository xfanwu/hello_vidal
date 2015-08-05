module Vidalo
  module REST
    module GET
      # Return number of total products
      def get_number_of_products
        send_api_request('products', { 'start-page' => 1, 'page-size' => 1 }).at('totalResults').text.to_i
      end


      # Return a set of Nokogiri Objects
      def search(type: nil, query: nil, start_page: 1, page_size: 10)
        if type.nil?
          raise ArgumentError.new 'Error: You need to define "type" at least (eg. "products")'
        end
        @res = send_api_request(type, {'q' => query, 'start-page' => start_page, 'page-size' => page_size })
        @res.search('entry').to_a if @res
      end


      # Return string
      def get_inner_text(type: nil, id: nil, node: nil)
        if type.nil? || id.nil? || node.nil?
          raise ArgumentError.new 'Error: You need to define "type", "id" and node name - eg. get_inner_text(type: "package", id: 5355, node: "title")'
        end
        result = send_api_request("#{type}/#{id}")
        result ?
          get_node_value(result.at('entry').at(node)) :
          ""
      end


      def get_node_value(node)
        node ?
          node.text :
          ""
      end


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
      
    end
  end
end
