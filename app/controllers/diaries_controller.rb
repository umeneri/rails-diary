class DiariesController < ApplicationController
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, :only => [:create, :find, :find_by_character]

  # GET /diaries
  # GET /diaries.json
  def index
    @diaries = Diary.all
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
  end

  # GET /diaries/new
  def new
    @diary = Diary.new
  end

  # GET /diaries/1/edit
  def edit
  end

  # POST /diaries
  # POST /diaries.json
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

  # PATCH/PUT /diaries/1
  # PATCH/PUT /diaries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to @diary, notice: 'Diary was successfully updated.' }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diaries/1
  # DELETE /diaries/1.json
  def destroy
    @diary.destroy
    respond_to do |format|
      format.html { redirect_to diaries_url, notice: 'Diary was successfully destroyed.' }
      format.json { head :no_content }
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
  end

  def find
    target_date = if (params[:date])
                    Date.parse(params[:date])
                  else
                    Date.current
                  end

    p target_date
    start_date = target_date.beginning_of_day
    end_date = target_date.end_of_day
    @diaries = Diary.where(user_id: params[:user_id]).where('created_at > ? AND created_at < ?', start_date, end_date)
  end

  def find_by_character
    @characters = Character.where(user_id: params[:user_id]).where(name: params[:name])
    @diaries = Diary.where(user_id: params[:user_id]).where(id: @characters.pluck(:diary_id))
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diary_params
      params.require(:diary).permit(:user_id, :body, :negaposi)
    end
end
