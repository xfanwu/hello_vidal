VIDAL_API_URL = "http://apirest-dev.vidal.fr/rest/api/"

class HelloVidal
  attr_accessor :conn
  
  def initialize(id, key)
    @conn = Faraday.new(url: VIDAL_API_URL,
                        request: { params_encoder: Faraday::FlatParamsEncoder },
                        params: { app_id: id, app_key: key }) do |faraday|
                          faraday.adapter Faraday.default_adapter
                        end
  end

 
  # Return number of total products
  def get_total_of_products
    send_api_request('products', { :'start-page' => 1, :'page-size' => 1 }).at('totalResults').text.to_i
  end


  # Return Nokogiri Object
  def search(type = nil, query = nil)
    send_api_request(type, {:'q' => query })
  end

  def get_inner_text(type = nil, id = nil, node = nil)
    request = send_api_request("#{type}/#{id}")
    get_node_value(request.at('entry').at(node)) if request
  end

  private 

  def send_api_request(keyword, params={})
    request = @conn.get do |req|
      req.url(keyword)
      unless params.empty?
        params.each do |param_key, param_value|
          req.params[param_key] = param_value
        end
      end
    end
    Nokogiri::XML(request.body).remove_namespaces!.at('feed') if request.status == 200 && Nokogiri::XML(request.body).errors.empty?
  end


  def get_node_value(node)
    node.text if node
  end
end
