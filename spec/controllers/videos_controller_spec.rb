require 'spec_helper'

describe VideosController do
  describe "GET show" do
    it "sets @video for  authinticated users" do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq video
    end

    it "sets @review for authinticated user " do
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      expect(assigns(:reviews)).to match_array([review1,review2])
    end

    it "redirects unauthinticated users to sign in page" do
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to sign_in_path
    end
  end
  
  describe "POST search" do
    it "sets @result for authinticated users" do
      session[:user_id] = Fabricate(:user).id
      tealeaf = Fabricate(:video, title: 'tealeaf')
      post :search, search_term: 'tea'
      expect(assigns(:results)).to eq ([tealeaf])
    end

    it "redirects unauthinticated users to sign in page" do
      futurama = Fabricate(:video, title: 'futurama')
      post :search, search_term: 'rama'
      expect(response).to redirect_to sign_in_path
    end
  end
end

