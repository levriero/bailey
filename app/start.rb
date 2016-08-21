require 'rufus-scheduler'
require_relative 'notifier'

scheduler = Rufus::Scheduler.new
notifier = Notifier.new

# scheduler.cron '0 12 * * *', properties
scheduler.in '3s', notifier

scheduler.join
