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
        format.turbo_stream
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Will was successfully created." }
        format.json { render :show, status: :created, location: @will }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_delegate_form", partial: "form", locals: { delegate: @delegate }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @delegate.update(delegate_params)
        format.turbo_stream
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Will was successfully updated." }
        format.json { render :show, status: :ok, location: @delegate }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("delegate_#{@delegate.id}_form", partial: "form", locals: { delegate: @delegate }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delegate.destroy
    
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to user_will_delegate_path, notice: "Delegate was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private

  def set_will
    @will = current_user.will
    @will ? true : false
    @delegates = @will.delegates
  end

  def set_delegate
    @delegate = @will.delegates.find(params[:id])
  end

  def delegate_params
    params.require(:delegate).permit(
      :first_name, :middle_name, :last_name, 
      :executor, :executor_rank,
      :relation, :note, :id, :_destroy)
  end

end
