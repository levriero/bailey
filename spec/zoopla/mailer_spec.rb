require 'zoopla/mailer'

describe Zoopla::Mailer do
  let!(:mailer) do
    path = File.expand_path('../../support/property_listings.json', __FILE__)
    data = JSON.parse(File.read(path), symbolize_names: true)

    described_class.new(data)
  end

  describe '#html_body' do
    it 'returns an HTML view of the properties dataset given' do
      content = /Cremer Street, Shoreditch, London, Greater London E2 - 460 p.w./

      expect(mailer.html_body).to match(content)
    end
  end
end
