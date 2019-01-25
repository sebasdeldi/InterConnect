require 'rails_helper'

RSpec.describe Generals::Task, type: :model do
  it "is valid with valid attributes" do
    operation = create(:operation)
  	obj = described_class.new(note: 'Llamar cliente', due_date: Date.today, operation: operation)
  	expect(obj).to be_valid
  end

  it "is not valid without date" do
    operation = create(:operation)
  	obj = described_class.new(note: 'Llamar cliente', due_date: nil, operation: operation)
  	expect(obj).not_to be_valid
  end

  it "is not valid without note" do
    operation = create(:operation)
  	obj = described_class.new(note: nil, due_date: Date.today, operation: operation)
  	expect(obj).not_to be_valid
  end

  it "is not valid without operation" do
    operation = create(:operation)
    obj = described_class.new(note: 'Llamar cliente', due_date: Date.today, operation: nil)
    expect(obj).not_to be_valid
  end
end
