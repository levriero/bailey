require 'nokogiri'
require 'open_rent/property_node'

describe OpenRent::PropertyNode do
  let!(:html_node) do
    doc = File.read(File.expand_path('spec/support/open_rent_response.html'))

    Nokogiri::HTML(doc).xpath('//div[@id="property-list"]/div')
  end

  describe '#to_hash' do
    it 'returns a normalised hash of the given node' do
      result = described_class.new(html_node).to_hash

      expect(result).to eq({
        property_name: 'Property Name',
        property_href: 'https://www.openrent.co.uk/property-to-rent/london/id',
        image_url: 'https://http://s3.image.dev',
        submitted_at: '2016-08-29T19:20:16+01:00',
        description: 'Best property EU',
        price: { per_week: 350, per_month: 1500 }
      })
    end
  end
end
