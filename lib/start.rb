require 'dotenv'
require 'rufus-scheduler'
require_relative 'zoopla/notifier'

Dotenv.load

params = {
  postcode: 'N1',
  town: 'London',
  listing_status: 'rent',
  maximum_price: 575,
  minimum_beds: 2,
  order_by: 'age',
  radius: 1,
  page_size: 15
}

scheduler = Rufus::Scheduler.new
notifier = Zoopla::Notifier.new(params)

# scheduler.cron '0 12 * * *', properties
scheduler.in '3s', notifier

scheduler.join
