require 'nokogiri'
require 'faraday'
require 'faraday_middleware'
require_relative 'property_node'

module OpenRent
  class Request
    def properties(params)
      res = conn.get('properties-to-rent', params)
      doc = Nokogiri::HTML(res.body)

      parse_html(doc)
    end

    private

    def conn
      @conn ||= Faraday.new('https://www.openrent.co.uk/') do |faraday|
        faraday.use FaradayMiddleware::FollowRedirects, limit: 1
        faraday.adapter Faraday.default_adapter
      end
    end

    def parse_html(doc)
      doc.xpath('//div[@id="property-list"]/div')[0..30].map do |node|
        OpenRent::PropertyNode.new(node).to_hash
      end
    end
  end
end
