require "rails_helper"

RSpec.describe Admin::PositionsController, type: :controller do
  before do
    @user = FactoryGirl.create :user, role: :admin
    @normal_user = FactoryGirl.create :user
    sign_in @user
    @position = FactoryGirl.create :position
  end

  describe "GET index" do
    context "respond to template position index" do
      before do
        get :index
      end
      it {expect(response).to render_template :index}
    end

    context "respond to root when normal user access to position index" do
      before do
        sign_out @user
        sign_in @normal_user
        get :index
      end
      it {expect(response).to redirect_to :root}
      it {expect(flash[:alert]).to eq "You are not authorized to access this page."}
    end
  end

  describe "GET show" do
    context "respond by showing the position" do
      before {get :show, id: @position.id}
      it {expect(response).to render_template :show}
    end
  end

  describe "GET new" do
    context "should respond new form of position" do
      before {get :new}
      it {expect(response).to render_template :new}
    end
  end

  describe "POST create" do
    subject {post :create, position: FactoryGirl.attributes_for(:position)}
    context "with valid attributes" do
      it {expect(subject).to redirect_to action: :show, id: assigns(:position).id}
      it {expect{subject}.to change(Position, :count).by(1)}
    end

    context "check success flash" do
      before {subject}
      it {expect(flash[:success]).to eql "Create success!"}
    end
  end

  describe "GET edit" do
    context "render edit form" do
      before {get :edit, id: @position.id}
      it {expect(response).to render_template :edit}
    end
  end

  describe "PUT update" do 
    subject {put :update, id: @position.id, 
      position: FactoryGirl.attributes_for(:position, name: "Team Leader", abbreviation: "TL")}
    context "changes position attributes" do
      before do 
        subject 
        @position.reload
      end
      it {expect(@position.name).to eql "Team Leader"}
      it {expect(@position.abbreviation).to eql "TL"}
    end

    context "redirect to the updated position" do
      before {subject}
      it {expect(subject).to redirect_to action: :show, id: assigns(:position).id}
      it {expect(flash[:info]).to eql "Updated Position!"}
    end
  end

  describe "DELETE destroy" do
    subject {delete :destroy, id: @position}
    context "delete position" do
      it {expect{subject}.to change(Position, :count).by(-1)}
    end

    context "redirect to index of position" do
      before {subject}
      it {expect(response).to redirect_to admin_positions_path}
    end
  end
end
