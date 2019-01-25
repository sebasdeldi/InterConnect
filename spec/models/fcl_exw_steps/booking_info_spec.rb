require 'rails_helper'

RSpec.describe FclExwSteps::BookingInfo, type: :model do
  it "is valid with valid attributes" do
  	operation = create(:operation)
  	obj = described_class.new(operation_id: operation.id)
  	expect(obj).to be_valid
  end

  it "is not valid without operation" do
  	obj = described_class.new(operation: nil)
  	expect(obj).not_to be_valid
  end
end
