class CharactersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:find]

  def find
    @characters = Character.where(user_id: params[:user_id]).limit(4)
  end
end
