require 'mail'
require 'pry'

module Zoopla
  class Mailer
    def initialize(data)
      @data = data
    end

    def deliver!
      mail.body(html_body)
      mail.subject("New properties for London #{@data[:postcode]} in Zoopla")

      mail.deliver!
    end

    def html_body
      @data[:listing].map do |property|
        %Q(
        <div>
          <h1>#{property[:displayable_address]} - #{property[:price]} p.w.</h1>
          <p>#{property[:short_description]}</p>
          <a href="#{property[:details_url]}" >See this property.</a>
        </div>
        ).gsub!(/[[:space:]]+/, ' ').strip
      end.join('')
    end

    private

    def mail
      @mail ||= Mail.new do
        to ENV.fetch('EMAIL_RECEIVER')
        from ENV.fetch('EMAIL_SENDER')
        content_type 'text/html; charset=UTF-8'
      end
    end
  end
end
