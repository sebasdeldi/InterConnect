require 'rails_helper'

RSpec.describe Documents::DocumentsTransferController, type: :controller do
	describe 'POST send_mail' do
	  let(:operation) { create(:operation) }
	 
	  it "redirects to operation path after sending email" do
	  	copy = double()
	  	allow(FclExwOperationMailer).to receive(:transfer_documents).and_return(copy)
	  	allow(copy).to receive(:deliver_later)
	    post :send_mail, params: {operation_id: operation}
	    expect(response).to redirect_to operation_path(operation)
	  end
	end
end
