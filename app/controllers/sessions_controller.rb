require 'httparty'
require 'json'
require 'socket'

class SessionsController < ApplicationController
  load_and_authorize_resource
  def new
    @user = current_user
    @keys = current_user.keys
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    @session.user_id = current_user.id
    # Start the HTTParty
    response = HTTParty.post("http://localhost:5000/new", 
                  :body => { :DbKeyId => @session.key_id,
                             :DbUserId => @session.user_id 
                           }.to_json, 
                  :headers => { 'Content-Type' => 'application/json' } )
    body = JSON.parse(response.body)

    @session.container_hashid = body["DockerId"]
    @session.container_host = Socket.gethostbyname(Socket.gethostname).first
    @session.container_port = body["SshPort"]
    @session.user_id = body["DbUserId"]
    @session.key_id = body["DbKeyId"]
    if @session.save  
      redirect_to sessions_path
    else
      flash.now[:danger] = "Container didnt work."
      render 'new'
    end
  end
  def destroy
    @session = Session.find(params[:id])
    response = HTTParty.delete("http://localhost:5000/delete",
                  :body => { :DockerId => @session.container_hashid }.to_json,
                  :headers => { 'Content-Type' => 'application/json' } )
    body = JSON.parse(response.body)
    if body["result"] == "success"
      @session.destroy
      redirect_to sessions_path
    else
      flash.now[:danger] = "Delete did not succeed"
      render 'index'
    end
  end

  def index
    session_query = Session.where(user_id: current_user.id)
    @sessions = session_query.order("created_at DESC")
  end

  def show
  end

  private
  def session_params
    params.require(:session).permit(:key_id)
  end
end
