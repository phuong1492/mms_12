require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryGirl.create :user
  end

  describe "GET #show" do
    context "responds by showing the user information" do
      before do
        sign_in @user
        get :show, id: @user.id
      end
      it {expect(response).to render_template :show}
    end
  end
end
