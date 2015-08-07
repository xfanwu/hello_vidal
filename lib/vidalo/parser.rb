module Vidalo
  module Parser
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


      # Return string
      def get_node_value(node)
        node ?
          node.text :
          ""
      end
  end
end
