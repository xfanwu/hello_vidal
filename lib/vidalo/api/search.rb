module Vidalo
  module API
    module Search
      # Get result of a set of Nokogiri Objects
      #
      # @params type [String], query [String], start_page [Fixnum], page_size [Fixnum]
      # @return [Array]
      def search(type: nil, query: nil, start_page: 1, page_size: 10)
        if type.nil?
          raise ArgumentError.new 'Error: You need to define "type" at least (eg. "products")'
        end
        @res = send_api_request(type, {'q' => query, 'start-page' => start_page, 'page-size' => page_size })
        @res.search('entry').to_a if @res
      end


      # Get result of a product's information
      #
      # @params id[Fixnum], aggregate[Array[String]], all_info[TrueClass]
      # @return [Nokogiri]
      #
      # Example:
      # api.search_product(id: 45, aggregate: ['UCD'])
      # api.search_product(id: 45, all_info: true)
      # 
      def search_product(id: nil, aggregate: [], all_info: nil)
        raise %{
        
          Need a Vidal Product ID.

        } unless id.is_a? Fixnum || id.to_i.to_s == id
        aggregate = %w(
        molecules
        indications
        ald_detail
        smr_asmr
        atc_classification
        VIDAL_CLASSIFICATION
        product_range
        document
        reco
        UCDS
        UNITS
        ) if all_info == true
        @res = send_api_request("product/#{id}", { 'aggregate' => aggregate })
      end
    end
  end
end
