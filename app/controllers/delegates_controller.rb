class DelegatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_delegate, except: [ :index, :new, :create ]
  layout "dashboard"

  def index
    @delegates = @will.delegates.ordered
  end

  def show
  end

  def new
    @delegate = @will.delegates.build
  end

  def edit
  end

  def create
    @delegate = @will.delegates.build(delegate_params)
    respond_to do |format|
      if @delegate.save
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Will was successfully created." }
        format.json { render :show, status: :created, location: @will }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @delegate.update(delegate_params)
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Will was successfully updated." }
        format.json { render :show, status: :ok, location: @will }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delegate.destroy
    respond_to do |format|
      format.html { redirect_to user_will_delegate_path, notice: "Delegate was successfully destroyed." }
    end
  end
  
  private

  def set_will
    @will = current_user.will
    @will ? true : false
  end

  def set_delegate
    @delegate = @will.delegates.find(params[:id])
  end

  def delegate_params
    params.require(:delegate).permit(
      :first_name, :middle_name, :last_name, 
      :relation, :note, :id, :_destroy,
      executor_attributes: [ :will_id, :id, :rank, :_destroy ],
      beneficiary_attributes: [ :will_id, :id, :_destroy ])
  end

end
