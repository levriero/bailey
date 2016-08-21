require 'zoopla/notifier'

describe Zoopla::Notifier do
  let(:query) { { min_price: 550, min_bedrooms: 4 } }
  let(:mailer) { double('Zoopla::Mailer', deliver!: nil) }

  before do
    allow(Zoopla::Mailer).to receive(:new).and_return(mailer)

    stub_request(:get, 'http://api.zoopla.co.uk/api/v1/property_listings.json')
    .with(query: { api_key: ENV.fetch('ZOOPLA_API_KEY') }.merge(query))
    .to_return(status: 200, body: { hello: 'world' }.to_json)
  end

  describe '#call' do
    it 'delegates email delivery to Zoopla::Mailer' do
      described_class.new(query).call(OpenStruct.new(id: 7590), Time.now)

      expect(mailer).to have_received(:deliver!)
    end
  end
end
