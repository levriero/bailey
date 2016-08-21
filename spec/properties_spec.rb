require 'spec_helper'
require_relative '../app/properties'

describe Properties do
  describe '#call' do
    it 'delegates to Request' do
      job = OpenStruct.new(id: 1234)
      params = { max_price: 750 }
      request = double('Request', properties: nil)

      allow(Request).to receive(:new).and_return(request)
      described_class.new(params).call(job, Time.now)

      expect(request).to have_received(:properties).with(params)
    end
  end
end
