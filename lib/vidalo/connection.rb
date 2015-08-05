require 'vidalo/rest/get'

module Vidalo
  class Connection
    include Vidalo::REST::GET
    attr_reader :app_id, :app_key

    def initialize(app_id, app_key)
      @app_id = app_id
      @app_key = app_key
      @conn = Faraday.new(url: VIDAL_API_URL,
                          request: { params_encoder: Faraday::FlatParamsEncoder },
                          params: { app_id: app_id, app_key: app_key }) do |faraday|
                            faraday.adapter Faraday.default_adapter
                          end
    end
  end
end
