require 'nokogiri'
require 'open_rent/property_node'

describe OpenRent::PropertyNode do
  let(:datetime) { DateTime.now.to_s }

  describe '#to_hash' do
    it 'returns a normalised hash of the given node' do
      result = described_class.new(Nokogiri::HTML(html_string)).to_hash

      expect(result).to eq({
        property_name: 'Property Name',
        property_href: 'https://www.openrent.co.uk/property-to-rent/london/id',
        image_url: 'https://http://s3.image.dev',
        submitted_at: datetime,
        description: 'Best property EU',
        price: { per_week: 350, per_month: 1500 }
      })
    end
  end

  def html_string
    %Q(
    <div>
      <div class="lic">
        <a class="banda pt" href="/id">Property Name</a>
        <abbr class="timeago" title="#{datetime}"></abbr>

        <div class="piw">£ 350 p.w.</div>
        <div class="pim">£ 1,500 pcm</div>
      </div>

      <div class="ldc">Best property EU</div>

      <a class="listingPic" data-original="http://s3.image.dev"></a>
    </div>
    )
  end
end
