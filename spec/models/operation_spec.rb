require 'rails_helper'

RSpec.describe Operation, type: :model do
  it "is valid with valid attributes" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).to be_valid
  end

  it "is not valid without modality" do
  	operation = described_class.new(modality: nil, pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without pol" do
  	operation = described_class.new(modality: 'LCL', pol: nil, pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without pod" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: nil,
  		origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without origin_address" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: nil, origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without origin_zip_code" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: nil, origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without origin_city" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: nil,
  		origin_state: 'Atlantico', origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without origin_state" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: nil , origin_country: 'COL')
  	expect(operation).not_to be_valid
  end

  it "is not valid without origin_country" do
  	operation = described_class.new(modality: 'LCL', pol: 'Barranquilla', pod: 
  		'NYC', origin_address: '7741 NW 7TH ST', origin_zip_code: '33216', origin_city: 'BQL',
  		origin_state: 'Atlantico', origin_country: nil)
  	expect(operation).not_to be_valid
  end

end
