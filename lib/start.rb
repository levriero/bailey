require 'dotenv'
require 'rufus-scheduler'
require_relative 'zoopla/notifier'

Dotenv.load

Mail.defaults do
  delivery_method(:smtp, { enable_starttls_auto: false })
end

params = {
  postcode: 'N1',
  town: 'London',
  listing_status: 'rent',
  minimum_price: 450,
  maximum_price: 575,
  minimum_beds: 2,
  order_by: 'age',
  page_size: 15
}

scheduler = Rufus::Scheduler.new
zoopla_notifier = Zoopla::Notifier.new(params)

scheduler.cron('0 12 * * *', zoopla_notifier)

scheduler.join
