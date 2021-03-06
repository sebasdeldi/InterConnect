require 'rails_helper'

RSpec.describe Documents::Insurance, type: :model do
	let(:operation) { create(:operation) }

  it "is valid with valid attributes" do
  	obj = described_class.new(operation_id: Operation.last.id)
  	expect(obj).to be_valid
  end

  it "is not valid without operation" do
  	obj = described_class.new(operation: nil)
  	expect(obj).not_to be_valid
  end
end
