RSpec.shared_examples "api unauthorized" do
  context "When not authorized" do
    before do
      action
    end

    it "returns unauthorized" do
      expect(response.status).to eq 500
      expect(response.body).to eq({ status: "error", message: "Authentication required for this operation" }.to_json)
    end
  end
end

RSpec.shared_examples "render template" do |name|
  it "renders template" do
    expect(response).to be_success
    expect(response).to render_template name
  end
end
