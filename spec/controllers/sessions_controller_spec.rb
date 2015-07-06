require 'spec_helper'


describe SessionsController do
  describe "GET new" do 
    it "renders the new template for unauthenticated users" do
      get :new 
      expect(response).to render_template :new
    end

    it "rendirects to the home page for authinticated users" do
      session[:user_id] = Fabricate(:user).id
      get :new
      expect(response).to redirect_to home_path
    end
  end

  describe "POST create " do
    
    context "with valid credentials" do
      it "puts the signed user in the session" do 
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password
        expect(session[:user_id]).to eq(lana.id)
      end
      it "redirects to the home page " do
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password
        expect(response).to redirect_to home_path
      end
      it "sets the notice" do 
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid credentials" do
      it "does not put the signed in user in the session" do 
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password + "wrong+password"
        expect(session[:user_id]).to be_nil
      end
      it "redirects to the sign in page"  do
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password + "wrong+password" 
        expect(response).to redirect_to sign_in_path
      end
      it "sets the error message" do
        lana = Fabricate(:user)
        post :create, email: lana.email, password: lana.password + "wrong+password" 
        expect(flash[:danger]).to be_present
      end
    end
  end 

  describe "GET destroy" do 

    it "clears the session for the user" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(session[:user_id]).to be_nil
    end 
    it "sets a message" do
      session[:user_id] = Fabricate(:user).id
      get :destroy
      expect(flash[:success]).not_to be_blank
    end
  end
end
