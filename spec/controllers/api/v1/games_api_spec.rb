require "rails_helper"

RSpec.describe Api::V1::GamesController do
  include_context "api common"

  let(:model) { Game }
  let(:token) { "gAm3tk" }

  # GET /api/v1/games
  describe "GET #index" do

    # Context
    include_context "api action" do
      let(:type) { :get }
      let(:route) { :index }
    end

    # Examples
    context "when not success" do
      it_behaves_like "api unauthorized"
    end

    context "when success" do
      before { action_success }

      it "returns success response" do
        expect(response).to be_success
      end
    end
  end

  # GET /api/v1/games/:token
  describe "GET #show" do
    subject(:game) { create :game }

    # Context
    include_context "api action" do
      let(:type) { :get }
      let(:route) { :show }
      let(:parameters_not_found) { { token: "unexsiting_token" } }
    end

    # Examples
    context "when not success" do
      it_behaves_like "api unauthorized"
      it_behaves_like "api not found", "Game not found"
    end

    context "when success" do
      before { action_success }

      it "returns success response" do
        expect(response).to be_success
      end
    end
  end

  # describe "POST /api/v1/games" do
  #   include_context "api action" do
  #     let(:type) { :post }
  #     let(:route) { "/api/v1/games" }
  #   end

  #   context "when not success" do
  #     it_behaves_like "api unauthorized"
  #   end

  #   context "when success" do
  #     it "creates new object" do
  #       expect { action_success }.to change { model.count }.by(1)
  #     end

  #     it "returns success response" do
  #       action_success
  #       expect(response).to be_success
  #     end
  #   end
  # end

end