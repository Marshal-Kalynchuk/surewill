class WillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, :authenticate_current_accessor, only: %i[ show update destroy release ]

  # GET /wills or /wills.json
  def index
    accessors = Accessor.where(email: current_user.email)
    if accessors
      @wills = accessors.collect{ |accessor| accessor.will }
    end
  end

  # GET /wills/1 or /wills/1.json
  def show
  end

  # GET /wills/new
  def new
    redirect_to edit_user_will_path(current_user, current_user.will) if current_user.will
    @will = Will.new
    @will.assets.build
    @will.accessors.build
  end

  # GET /wills/1/edit
  def edit
    redirect_to new_user_will_path(current_user) unless current_user.will
    @will = current_user.will
    @will.assets.build unless @will.assets
    @will.accessors.build unless @will.accessors
  end

  # POST /wills or /wills.json
  def create
    redirect_to edit_user_will_path(current_user.will) if current_user.will
    @will = current_user.build_will(will_params)
    respond_to do |format|
      if @will.save
        format.html { redirect_to user_will_url(current_user, @will), notice: "Will was successfully created." }
        format.json { render :show, status: :created, location: @will }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wills/1 or /wills/1.json
  def update
    respond_to do |format|

      if @will.update(will_params)
        format.html { redirect_to user_will_url(current_user, @will), notice: "Will was successfully updated." }
        format.json { render :show, status: :ok, location: @will }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wills/1 or /wills/1.json
  def destroy
    @will.destroy
    respond_to do |format|
      format.html { redirect_to wills_url, notice: "Will was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def release
    if @current_accessor.can_release
      @will.release_user_will(@current_accessor)
      if @will.save
        redirect_to user_will_path(will_params)
      else
        flash[:alert] = "An error occurred"
        redirect_to :root
      end
    else
      flash[:alert] = "You are not permitted to release this will!"
      redirect_to :root
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = Will.find(params[:id])
      @assets = @will.assets 
      @accessors = @will.accessors
    end

    def authenticate_current_accessor
      @current_accessor = @will.accessors.find_by(email: current_user.email)
      redirect_to user_wills_url(current_user) unless @current_accessor || @will == current_user.will
    end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(
        :testator, :user_id, :public, :prepaid, :released,
      assets_attributes: [ :title, :description, :image, :id ],
      accessors_attributes: [ :name, :email, :role, :can_release, :id ]
      )
    end

end
