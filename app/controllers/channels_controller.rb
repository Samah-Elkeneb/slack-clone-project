class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :require_admin, only: %i[ new create edit update destroy]


  def messages
    @active_channel = Channel.find(params[:id])
    @messages = @active_channel.messages.includes(:user).order(created_at: :desc).limit(10)
    @message = @active_channel.messages.build
    render partial: "messages",
      locals: { new_message: @message, channel: @active_channel, messages: @messages.reverse }
  end

  def load_more
    @channel = Channel.find(params[:id])
    before_id = params[:before_id].to_i
    limit = (params[:limit] || 10).to_i

    @messages = @channel.messages
                      .where("id < ?", before_id)
                      .order(id: :desc)
                      .limit(limit)

    return head :no_content if @messages.empty?

    respond_to do |format|
      format.turbo_stream
      format.html { render partial: "message_item", collection: @messages.reverse, as: :message }
  end
end

  # GET /channels or /channels.json
  def index
    @channels = Channel.all
  end

  # GET /channels/1 or /channels/1.json
  def show
  end

  # GET /channels/new
  def new
    @channel = Channel.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params)

    respond_to do |format|
      if @channel.save
        format.html { redirect_to @channel, notice: "Channel was successfully created." }
        format.json { render :show, status: :created, location: @channel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1 or /channels/1.json
  def update
    respond_to do |format|
      if @channel.update(channel_params)
        format.html { redirect_to @channel, notice: "Channel was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @channel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @channel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1 or /channels/1.json
  def destroy
    @channel.destroy!

    respond_to do |format|
      format.html { redirect_to channels_path, notice: "Channel was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def channel_params
      params.expect(channel: [ :name ])
    end
end
