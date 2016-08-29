module OpenRent
  class PropertyNode
    def initialize(node)
      @node = node
    end

    def to_hash
      keys = %i(property_name property_href image_url submitted_at description)

      keys.each_with_object({}) { |key, memo| memo[key] = send(key) }.merge({
        price: { per_week: price_per_week, per_month: price_per_month }
      })
    end

    private

    def property_name
      @node.at_xpath('.//div[@class="lic"]/a[@class="banda pt"]/text()').to_s.strip
    end

    def property_href
      node_href = @node.at_xpath('.//div[@class="lic"]/a[@class="banda pt"]/@href')

      return nil unless node_href

      "https://www.openrent.co.uk/property-to-rent/london#{node_href.value}"
    end

    def image_url
      node_img_href = @node.at_xpath('.//a[@class="listingPic"]//@data-original')

      return nil unless node_img_href

      'https://' + node_img_href.value.gsub(/_t\.JPG\z/, '')
    end

    def submitted_at
      datetime = @node.at_xpath('//div[@class="lic"]//abbr[@class="timeago"]/@title')

      return unless datetime

      datetime.value
    end

    def description
      @node.at_xpath('.//div[@class="ldc"]/text()').to_s.gsub(/\s+/, ' ').strip
    end

    def price_per_week
      @node.at_xpath('.//div[@class="lic"]//div[@class="piw"]/text()').to_s[/[0-9]+/].to_i
    end

    def price_per_month
      price_string = @node.at_xpath('.//div[@class="lic"]//div[@class="pim"]/text()').to_s[/[0-9,[0-9]]+/]

      return 0 unless price_string

      price_string.gsub(',','').to_i
    end
  end
end
