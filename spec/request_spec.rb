require 'spec_helper'
require_relative '../app/request'

RSpec.describe Request do
  let(:request_url) { 'http://api.zoopla.co.uk/api/v1' }
  let(:mocked_body) { { property_type: 'flat' } }

  describe '#properties' do
    it 'returns a JSON response for Zoopla properties' do
      stub_request(:get, "#{request_url}/property_listings.json")
      .with(query: { api_key: ENV.fetch('ZOOPLA_API_KEY') })
      .to_return(status: 200, body: mocked_body.to_json)

      expect(subject.properties).to eq(mocked_body)
    end
  end
end
