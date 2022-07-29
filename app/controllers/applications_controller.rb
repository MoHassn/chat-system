class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
    render json: @applications.select(:name, :token).to_json(except: :id)
  end

  def create
    @application = Application.create!(application_params)
    render json: @application.to_json(except: [:id, :chat_count, :next_chat_number]), status: :created
  end


  def application_params
    # whitelist params
    params.permit(:name)
  end
end
