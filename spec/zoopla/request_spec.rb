require 'zoopla/request'

describe Zoopla::Request do
  let(:request_url) { 'http://api.zoopla.co.uk/api/v1' }
  let(:mocked_response) { { property_type: 'flat' } }
  let(:query) { { status: 'rent', postcode: 'N1', town: 'London' } }

  before do
    ENV['ZOOPLA_API_KEY'] = 'zoopla-key'

    stub_request(:get, "#{request_url}/property_listings.json")
    .with(query: { api_key: ENV.fetch('ZOOPLA_API_KEY') }.merge(query))
    .to_return(status: 200, body: mocked_response.to_json)
  end

  describe '#properties' do
    it 'returns a hash with filtered properties' do
      results = subject.properties(query)

      expect(results).to eq(mocked_response)
    end
  end
end
