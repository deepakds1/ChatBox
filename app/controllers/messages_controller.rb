class MessagesController < ApplicationController
  respond_to :html, :js, :json

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create!(user_params)
    PrivatePub.publish_to("/messages/new", user_params: @message)
  end
end

def new
  @message = Message.new
end

def destroy
  @message.destroy
end

private

def user_params
  params.require(:message).permit(:content)
end