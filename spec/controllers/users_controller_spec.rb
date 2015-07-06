require 'spec_helper'

describe UsersController do
  describe "Get new" do
    it "sets @user " do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end
  describe "POST create" do
    context "with valid input" do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "create the user" do
        expect(User.count).to eq(1)
      end
      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with invalid input" do
      before do
        post :create, user: {password: "password",full_name: "Keving Wang"}
      end

      it "does not create a user" do
        expect(User.count).to eq(0)
      end
      it "redirects render :new template" do
        post :create, user: {password: "password",full_name: "Keving Wang"}
        expect(response).to render_template :new
      end
      it "sets @user" do
        post :create, user: {password: "password",full_name: "Keving Wang"}
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end
end