class MessagesController < ApplicationController
  def index
    @application = Application.find_by(token:  params[:application_id])
    if !@application
      return render json: { :message => "application not found" }.to_json, status: :not_found
    end

    @chat = Chat.find_by(application: @application.id, number: params[:chat_id])

    if !@chat
      return render json: { :message => "chat not found" }.to_json, status: :not_found
    end
    
    @messages = Message.search(
      query: {
        bool: {
          must: [
            {
              match: {
                body: params[:query]
              }
            }
          ], 
          filter: [
            {
              term: {
                "chat_id":  @chat.id
              }
            }
          ]     
        }
    }).records
    render json: @messages.to_json(:except => [:id, :chat_id])
  end

  
  def create
    @application = Application.find_by(token:  params[:application_id])
    if !@application
      return render json: { :message => "application not found" }.to_json, status: :not_found
    end

    @chat = Chat.find_by(application: @application.id, number: params[:chat_id])

    if !@chat
      return render json: { :message => "chat not found" }.to_json, status: :not_found
    end
    number = get_message_number(@chat.id)
 
    @chat.messages.create(number: number, body: params[:body])

    render json: {message_number: number}, status: :created

  end

  def get_message_number chat_id
    Chat.transaction do
      chat = Chat.lock.find(chat_id)
      message_number = chat.next_message_number
      chat.next_message_number += 1
      chat.save!
      message_number
    end
  end
  
end