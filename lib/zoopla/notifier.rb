require_relative 'mailer'
require_relative 'request'

module Zoopla
  class Notifier
    def initialize(params)
      @params = default_params.merge(params)
    end

    def call(job, time)
      puts "* #{time} - #{self.class.name} scheduled with id #{job.id}"

      Zoopla::Mailer.new(properties).deliver!
    end

    private

    def properties
      Zoopla::Request.new.properties(@params)
    end

    def default_params
      {
        town: 'London',
        listing_status: 'rent',
        order_by: 'age',
        ordering: 'descending',
        page_size: 15
      }
    end
  end
end
