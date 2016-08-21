require 'mail'
require_relative 'request'

class Notifier
  def call(job, time)
    puts "* #{time} - Properties scheduler called for #{job.id}"

    html_content = html_body
    Mail.deliver do
      to ENV.fetch('EMAIL_RECEIVER')
      from ENV.fetch('EMAIL_SENDER')
      subject 'New properties for London N1 in Zoopla'

      html_part do
        content_type 'text/html; charset=UTF-8'
        body html_content
      end
    end
  end

  def html_body
    properties[:listing].map do |property|
      %Q(
        <div>
          <h1>#{property[:displayable_address]} - #{property[:price]} pw</h1>
          <p>#{property[:short_description]}</p>
          <a href="#{property[:details_url]}" >See this property</a>
        </div>
      ).gsub!(/[[:space:]]+/, ' ').strip
    end.join('')
  end

  def properties
    Request.new.properties({
      postcode: 'N1',
      town: 'London',
      listing_status: 'rent',
      maximum_price: 575,
      order_by: 'age',
      radius: 1,
      page_size: 25
    })
  end
end
