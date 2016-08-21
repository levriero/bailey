require_relative 'mailer'
require_relative 'request'

module Zoopla
  class Notifier
    def initialize(params)
      @params = params
    end

    def call(job, time)
      puts "* #{time} - #{self.class.name} scheduled with id #{job.id}"

      Zoopla::Mailer.new(properties).deliver!
    end

    private

    def properties
      Zoopla::Request.new.properties(@params)
    end
  end
end
