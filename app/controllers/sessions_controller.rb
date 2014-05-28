require 'httparty'
require 'json'

class SessionsController < ApplicationController
  def new
    @user = current_user
    @keys = current_user.keys
    @session = Session.new
  end

  def create
    @session = Session.new(session_params)
    @session.user_id = current_user.id
    # Start the HTTParty
    @result = HTTParty.post("http://localhost:5000/new", 
                  :body => { :DbKeyId => @session.key_id,
                             :DbUserId => @session.user_id 
                           }.to_json, 
                  :headers => { 'Content-Type' => 'application/json' } )
    redirect_to root_path
  end

  def index
  end

  def show
  end

  private
  def session_params
    params.require(:session).permit(:key_id)
  end
end
