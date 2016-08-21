require 'mail'
require 'erb'

module Zoopla
  class Mailer
    def initialize(data)
      @data = data
      @template = File.read(File.expand_path('../layout.html.erb', __FILE__))
    end

    def deliver!
      mail.body(html_body)
      mail.subject("New properties for London #{@data[:postcode]} in Zoopla")

      mail.deliver!
    end

    def html_body
      @data[:listing].map do |property|
        ERB.new(@template).result(binding).gsub!(/[[:space:]]+/, ' ').strip
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
