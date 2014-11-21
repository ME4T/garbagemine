class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, :except => [:show, :index]
  # GET /things
  # GET /things.json
  def index
    @filterrific = Filterrific.new(Thing, params[:filterrific] || session[:filterrific_things])
    @things = Thing.filterrific_find(@filterrific).paginate(:page => params[:page], :per_page => 2)

  end

  # GET /things/1
  # GET /things/1.json
  def show
  end

  # GET /things/new
  def new
    @thing = Thing.new
    if(params[:parent])
      @thing.parent_id = params[:parent]
      @parent = Thing.find(@thing.parent_id)
    end
  end

  # GET /things/1/edit
  def edit
  end

  # POST /things
  # POST /things.json
  def create
    @thing = Thing.new(thing_params)
    @thing.user_id = current_user.id

    respond_to do |format|
      if @thing.save
        format.html { redirect_to @thing, notice: 'Thing was successfully created.' }
        format.json { render :show, status: :created, location: @thing }
      else
        format.html { render :new }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end





  # PATCH/PUT /things/1
  # PATCH/PUT /things/1.json
  def update
    respond_to do |format|
      if @thing.update(thing_params)
        format.html { redirect_to @thing, notice: 'Thing was successfully updated.' }
        format.json { render :show, status: :ok, location: @thing }
      else
        format.html { render :edit }
        format.json { render json: @thing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /things/1
  # DELETE /things/1.json
  def destroy
    @thing.destroy
    respond_to do |format|
      format.html { redirect_to things_url, notice: 'Thing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def votecreative
      @thing = Thing.find(params[:id])
      if current_user.voted_up_on? @thing, :vote_scope => 'creative'
        @thing.unliked_by current_user, :vote_scope => 'creative'
      else 
        @thing.liked_by current_user, :vote_scope => 'creative'
      end
      respond_to do |format|
          format.html { redirect_to :back }
          format.json { render json: { count: 0 } }
      end
  end
  def votebeautiful
      @thing = Thing.find(params[:id])
      if current_user.voted_up_on? @thing, :vote_scope => 'beautiful'
        @thing.unliked_by current_user, :vote_scope => 'beautiful'
      else 
        @thing.liked_by current_user, :vote_scope => 'beautiful'
      end
      respond_to do |format|
          format.html { redirect_to :back }
          format.json { render json: { count: 0 } }
      end
  end
  def voteinspiring
      @thing = Thing.find(params[:id])
      if current_user.voted_up_on? @thing, :vote_scope => 'inspiring'
        @thing.unliked_by current_user, :vote_scope => 'inspiring'
      else 
        @thing.liked_by current_user, :vote_scope => 'inspiring'
      end
      respond_to do |format|
          format.html { redirect_to :back }
          format.json { render json: { count: 0 } }
      end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:parent_id, :user_id, :bounty, :text, :type, :url, :image)
    end
end
