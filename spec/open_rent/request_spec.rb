require 'open_rent/request'

describe OpenRent::Request do
  describe '#properties' do
    let!(:response) do
      File.read(File.expand_path('spec/support/open_rent_response.html'))
    end

    let!(:params) do
      {
        prices_min: 1900,
        prices_max: 2500,
        bedrooms_min: 2,
        term: 'Canonbury, London, United Kingdom'
      }
    end

    before do
      stub_request(:get, 'https://www.openrent.co.uk/properties-to-rent')
      .with(query: params)
      .to_return(status: 200, body: response)
    end

    it 'returns a hash with openrent properties' do
      properties = described_class.new.properties(params)

      expect(properties).to eq([
        {
          property_name: 'Property Name',
          property_href: 'https://www.openrent.co.uk/property-to-rent/london/id',
          image_url: 'https://http://s3.image.dev',
          submitted_at: '2016-08-29T19:20:16+01:00',
          description: 'Best property EU',
          price: { per_week: 350, per_month: 1500 }
        }
      ])
    end
  end
end
