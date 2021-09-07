require "rails_helper"
include SessionsHelper

RSpec.describe UsersController, type: :controller do
  let(:user){FactoryBot.create :user}
  let(:params) {{id: user.id}}

  describe "GET /index" do
    context "when go to job index page" do
      before do
        get :index
      end

      it "should redirect to user_url" do
        expect(response.response_code).to eq 200
      end
    end
  end

  describe "GET /show" do
    context "when user do not exist" do
      before do
        get :show, params: {id: 1}
      end

      it "should redirect to root_path" do
        expect(response).to redirect_to root_url
      end
    end

    context "when user do exist" do
      before do
        get :show, params: {id: user.id}
      end

      it "should redirect to user page" do
        expect(assigns(:user)).to eq user
      end
    end
  end
end
