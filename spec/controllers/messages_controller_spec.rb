require 'spec_helper'

describe MessagesController do

  describe "GET 'publish'" do
    it "returns http success" do
      get 'publish'
      response.should be_success
    end
  end

  describe "GET 'subscribe'" do
    it "returns http success" do
      get 'subscribe'
      response.should be_success
    end
  end

  describe "GET 'history'" do
    it "returns http success" do
      get 'history'
      response.should be_success
    end
  end

end
