class ChatsController < ApplicationController
  def index
    @application = Application.find_by(token: params[:application_id]) 
    render json: @application.chats.select(:number, :message_count).to_json(except: :id)
  end

  def create
    @application = Application.find_by(token: params[:application_id])
    if !@application
      return render json: { :message => "application not found" }.to_json, status: :not_found
    end

    number = get_chat_number(params[:application_id])
    @application.chats.create(number: number)
    render json: {chat_number: number}, status: :created
  end
  def get_chat_number application_token
    Application.transaction do
      app = Application.lock.find_by(token: application_token)
      chat_number = app.next_chat_number
      app.next_chat_number += 1
      app.save!
      chat_number
    end
  end
end
