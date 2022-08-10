class WillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, :authenticate_user_accessor, only: %i[ show update destroy release ]

  # GET /wills or /wills.json
  def index
    accessors = Accessor.where(user: current_user)
    if accessors
      @wills = accessors.collect{ |accessor| accessor.will }
    end
  end

  # GET /wills/1 or /wills/1.json
  def show
  end

  # GET /wills/new
  def new
    if user_signed_in? && current_user.will
      redirect_to edit_user_will_path(current_user, current_user.will)
    end
    @will = Will.new
    @will.assets.build
    @will.accessors.build
  end

  # GET /wills/1/edit
  def edit
    if current_user.will
      @will = current_user.will
      @will.assets.build unless @will.assets
      @will.accessors.build unless @will.accessors
    else
      redirect_to new_user_will_path(current_user)
    end
  end

  # POST /wills or /wills.json
  def create
    if user_signed_in? && current_user.will
      redirect_to edit_user_will_path(current_user.will)
    else
      link_users
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
  end

  # PATCH/PUT /wills/1 or /wills/1.json
  def update
    respond_to do |format|
      link_users
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
    if @accessor_user.can_release
      @will.released = true
      @will.releaser = @accessor_user
      if @will.save
        redirect_to user_will_path(will_params)
      else
        flash[:alert] = "An error occurred"
        redirect_to :root
      end
    else
      flase[:alert] = "You are not permitted to release this will!"
      redirect_to :root
    end
  end

  private

    def link_users
      params[:will][:accessors_attributes].each do |k, v|
        # hold invites
        user = User.find_by(email: v[:email]) || User.invite!(email: v[:email]) 
        v[:user_id] = user.id
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = Will.find(params[:id])
      @assets = @will.assets 
      @accessors = @will.accessors
    end

    def authenticate_user_accessor
      @accessor_user = Accessor.find_by(will_id: @will.id, user_id: current_user.id)
      unless @accessor_user || current_user.will == @will
        redirect_to user_wills_url(current_user)
      end
    end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(
        :testator, :user_id, :public, :prepaid, :death_certificate,
      assets_attributes: [ :title, :description, :image, :id ],
      accessors_attributes: [ :name, :email, :accessor_type, :can_release, :id, :user_id]
      )
    end

end
