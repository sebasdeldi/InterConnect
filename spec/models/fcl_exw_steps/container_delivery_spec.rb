require 'rails_helper'

RSpec.describe FclExwSteps::ContainerDelivery, type: :model do
	let(:operation) { create(:operation) }

  it "is valid with valid attributes" do
  	obj = described_class.new(operation_id: operation.id)
  	expect(obj).to be_valid
  end

  it "is not valid without operation" do
  	obj = described_class.new(operation: nil)
  	expect(obj).not_to be_valid
  end
end
