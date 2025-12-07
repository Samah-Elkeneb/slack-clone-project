class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      ActionCable.server.broadcast(
        "#{@message.channel.name}_#{@message.channel.id}",
        render_to_string(partial: "channels/message_item", locals: { message: @message })
    )
    head :ok
    end
  end

  def update
    @message.update(message_params)
  end

  def destroy
    @message.destroy!
  end

  private
    def set_message
      @message = Message.find(params.expect(:id))
    end

    def message_params
      params.expect(message: [ :content, :channel_id, :user_id ])
    end
end
