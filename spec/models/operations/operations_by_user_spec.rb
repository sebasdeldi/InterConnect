require 'rails_helper'

RSpec.describe Operations::OperationsByUser, type: :model do

  it "is valid with valid attributes" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: agent.id, shipper_id: shipper.id,
  		consignee_id: consignee.id, operation_id: operation.id,
  		representative_id: representative.id)
  	expect(obj).to be_valid
  end

  it "is not valid without agent" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: nil, shipper_id: shipper.id,
  		consignee_id: consignee.id, operation_id: operation.id,
  		representative_id: representative.id)
  	expect(obj).not_to be_valid
  end

  it "is not valid without shipper" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: agent.id, shipper_id: nil,
  		consignee_id: consignee.id, operation_id: operation.id,
  		representative_id: representative.id)
  	expect(obj).not_to be_valid
  end

  it "is not valid without consignee" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: agent.id, shipper_id: shipper.id,
  		consignee_id: nil, operation_id: operation.id,
  		representative_id: representative.id)
  	expect(obj).not_to be_valid
  end

  it "is not valid without operation" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: agent.id, shipper_id: shipper.id,
  		consignee_id: consignee.id, operation_id: nil,
  		representative_id: representative.id)
  	expect(obj).not_to be_valid
  end

  it "is not valid without representative" do
    operation = create(:operation)
    shipper = create(:shipper)
    agent = create(:agent)
    consignee = create(:consignee)
    representative = create(:representative)
  	obj = described_class.new(agent_id: agent.id, shipper_id: shipper.id,
  		consignee_id: consignee.id, operation_id: operation.id,
  		representative_id: nil)
  	expect(obj).not_to be_valid
  end
end

