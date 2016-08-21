require_relative 'request'

class Properties
  def initialize(params = {})
    @params = params
  end

  def call(job, time)
    puts "* #{time} - Properties scheduler called for #{job.id}"

    Request.new.properties(@params)
  end
end
