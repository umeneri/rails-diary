class DiariesController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :find, :find_by_character]

  def create
    @diary = Diary.new(diary_params)

    respond_to do |format|
      if @diary.save_with_characters
        format.html { redirect_to @diary, notice: 'Diary was successfully created.' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  def calendar_index
  end

  def calendar
    target_date = if (params[:year] && params[:month])
                    Date.new(params[:year].to_i, params[:month].to_i)
                  else
                    Date.current
                  end

    start_date = target_date.beginning_of_month
    end_date = target_date.end_of_month

    @diaries = Diary.where('created_at > ? AND created_at < ?', start_date, end_date)
                    .where(user_id: params[:userId])
                    .order(:created_at)
  end

  def find
    target_date = if (params[:date])
                    Time.parse(params[:date])
                  else
                    Time.current
                  end

    start_date = target_date.beginning_of_day
    end_date = target_date.end_of_day
    @diaries = Diary.where(user_id: params[:user_id]).where('created_at > ? AND created_at < ?', start_date, end_date)
  end

  def find_by_character
    @characters = Character.where(user_id: params[:user_id]).where(name: params[:name])
    @diaries = Diary.where(user_id: params[:user_id]).where(id: @characters.pluck(:diary_id))
  end

  private

    def diary_params
      params.require(:diary).permit(:user_id, :body, :negaposi)
    end
end
