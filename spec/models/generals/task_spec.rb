require 'rails_helper'

RSpec.describe Generals::Task, type: :model do
  let(:operation) { create(:operation) }

  it "is valid with valid attributes" do
  	obj = described_class.new(note: 'Llamar cliente', due_date: Date.today, operation: operation)
  	expect(obj).to be_valid
  end

  it "is not valid without date" do
  	obj = described_class.new(note: 'Llamar cliente', due_date: nil, operation: operation)
  	expect(obj).not_to be_valid
  end

  it "is not valid without note" do
  	obj = described_class.new(note: nil, due_date: Date.today, operation: operation)
  	expect(obj).not_to be_valid
  end

  it "is not valid without operation" do
    obj = described_class.new(note: 'Llamar cliente', due_date: Date.today, operation: nil)
    expect(obj).not_to be_valid
  end
end
