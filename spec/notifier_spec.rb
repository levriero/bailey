require 'spec_helper'
require_relative '../app/notifier'

describe Notifier do
  before do
    file_path = File.expand_path('../support/property_listings.json', __FILE__)
    response = JSON.parse(File.read(file_path), symbolize_names: true)

    allow_any_instance_of(Request).to receive(:properties).and_return(response)
  end

  describe '#body' do
    it 'returns an HTML view of the properties fetched' do
      expect(described_class.new.html_body).to match(/Cremer Street, Shoreditch, London, Greater London E2 - 460 pw/)
    end
  end
end
