class ChatChannel < ApplicationCable::Channel
  rescue_from "MyError", with: :deliver_error_message

  def subscribed
    stream_from "#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast("#{params[:room]}", data)
  end

  private
  def deliver_error_message(e)
      # broadcast_to(...)
    end
end
