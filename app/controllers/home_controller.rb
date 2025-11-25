class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @channels = Channel.all
    @active_channel = @channels.first
    @active_channel_id = @active_channel.id
    @channel = @active_channel
    @messages = @active_channel.messages.includes(:user)
    @message = @channel.messages.build
  end
end
