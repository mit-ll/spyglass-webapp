class KeysController < ApplicationController
  load_and_authorize_resource
  def new
    @key = Key.new
  end

  def create
    @key = Key.new(key_params)
    @key.user_id = current_user.id
    if @key.save
      flash[:success] = "Key Saved."
      redirect_to keys_path
    else
      flash.now[:danger] = "There were errors with your key."
      render 'new'
    end
  end

  def show
  end

  def index
    key_query = Key.where(user_id: current_user.id)
    @keys = key_query.order("created_at DESC")
  end

  def destroy
    @key = Key.find(params[:id])
    @key.destroy
    redirect_to keys_path
  end

  private
    def key_params
      params.require(:key).permit(:keyname, :sshkey)
    end
end
