require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  before do
    @user = FactoryGirl.create :user, role: :admin
    @normal_user = FactoryGirl.create :user
    sign_in @user
  end
  
  describe "GET #index" do
    context "response to render template index of admin" do
      before do 
        get :index
      end
      it {expect(response).to render_template :index}
    end

    context "response when normal user to access to admin index" do
      before do
        sign_out @user
        sign_in @normal_user
        get :index
      end

      it {expect(flash[:danger]).to eq "You are not authorized to access this page."}
      it {expect(response).to redirect_to :root}
    end

    context "response when guest to access to admin index" do
      before do
        sign_out @user
        get :index
      end

      it {expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")}
      it {expect(response).to redirect_to new_user_session_url}
    end
  end

  describe "GET #show" do
    context "responds by showing the user information" do
      before do
        get :show, id: @user.id
      end
      it {expect(response).to render_template :show}
    end
  end

  describe "GET new" do
    context "should response show form of use" do
      before do
        get :new
      end
      it {expect(response).to render_template :new}
    end
  end
end
