class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @channels = Channel.for_user(current_user)
  end
  def test_frontend
    @channels = Channel.for_user(current_user)
  end
end
