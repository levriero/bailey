require 'json'
require 'faraday'

module Zoopla
  class Request
    def properties(params)
      res = conn.get('/api/v1/property_listings.json', params.merge(api_key))

      JSON.parse(res.body, symbolize_names: true)
    end

    private

    def conn
      @conn ||= Faraday.new('http://api.zoopla.co.uk')
    end

    def api_key
      { api_key: ENV.fetch('ZOOPLA_API_KEY') }
    end
  end
end
