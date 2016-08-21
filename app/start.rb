require 'rufus-scheduler'
require_relative 'properties'

scheduler = Rufus::Scheduler.new
properties = Properties.new({
  postcode: 'N1',
  town: 'London',
  listing_status: 'rent',
  maximum_price: 575,
  order_by: 'age',
  radius: 1,
  page_size: 100
})

# scheduler.cron '0 12 * * *', properties
scheduler.in '3s', properties

scheduler.join
