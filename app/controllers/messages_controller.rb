class MessagesController < ApplicationController
  before_action :require_login

  def index
    @messages = current_user.messages
  end

  def new
    @friend = current_user.friends.sample
    @message = current_user.messages.build
  end

  def create
    @message = current_user.messages.create(message_params)
    redirect_to :messages, notice: 'Created successfully'
  end

  private
  def message_params
    params[:message].permit(:body, :recipient_id)
  end
end
