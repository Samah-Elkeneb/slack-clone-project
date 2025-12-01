class ChannelsController < ApplicationController
  before_action :set_channel, only: %i[ show edit update destroy add_member]
  before_action :authenticate_user!
  before_action :require_admin!, only: %i[ edit update destroy add_member]

  # CRUD
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
  # not used
  # GET /channels or /channels.json
  def index
    @channels = Channel.all
  end

# GET /channels/1 or /channels/1.json
def show
  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: turbo_stream.update(
        "modal_frame",
        partial: "channel_content",
        locals: { channel: @channel }
      )
    end
    format.html { render :show }
  end
end

  def add_member
  @user = User.find(params[:user_id])

  return if @channel.users.include?(@user)

  @channel.users << @user

  respond_to do |format|
    format.turbo_stream
    format.html { redirect_to @channel }
  end
end


  # GET /channels/new
  def new
    @channel = Channel.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          "modal_frame",
          partial: "new_channel",
          locals: { channel: @channel }
        )
      end
    format.html { render :new }
    end
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels or /channels.json
  def create
    @channel = Channel.new(channel_params)
    @channel.creator = current_user

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
      format.html { redirect_to home_index_path, notice: "Channel was successfully destroyed.", status: :see_other }
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
      params.expect(channel: [ :name, :public ])
    end

    def require_admin!
      redirect_to home_index_path, alert: "Not allowed" unless current_user.admin?(@channel)
    end
end
