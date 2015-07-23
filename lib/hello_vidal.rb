require 'nokogiri'
require 'faraday'

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
    node.text if node.present?
  end
end
