class CharactersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:find]

  def find
    @characters = Character.where(user_id: params[:user_id]).select(:name).distinct.first(4)
  end
end
