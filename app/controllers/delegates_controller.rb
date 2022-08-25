class DelegatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, execpt: %i[ destory ]
  before_action :set_delegate, only: %i[ show edit update destroy ]
  layout "dashboard"

  def index
  end

  def show
  end

  def new
    @delegate = @delegates.build
    @delegate.build_address
  end

  def edit
  end

  def create
    @delegate = @delegates.build(delegate_params)

    respond_to do |format|
      if @delegate.save
        @size = @will.delegates.size
        format.turbo_stream
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Delegate was successfully created." }
        format.json { render :show, status: :created, location: @delegate }
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
        @update_properties =  @delegate.properties.to_a
        format.turbo_stream
        format.html { redirect_to user_will_delegates_path(current_user), notice: "Delegate was successfully updated." }
        format.json { render :show, status: :ok, location: @delegate }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("delegate_#{@delegate.id}_form", partial: "form", locals: { delegate: @delegate }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @delegate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @update_properties =  @delegate.properties.to_a
    @update_finances = @delegate.finances.to_a
    @delegate.destroy
    @size = @will.delegates.size
    @update_properties.each do |property| 
      property.primary_valid?
      property.secondary_valid?
    end
    @update_finances.each{ |finance| finance.primary_valid? }

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to user_will_delegate_path, notice: "Delegate was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private

  def set_will
    @will = current_user.will
    redirect_to :root if @will.nil?
    @delegates = @will.delegates
  end

  def set_delegate
    @delegate = @delegates.find(params[:id])
  end

  def delegate_params
    params.require(:delegate).permit(
      :first_name, :middle_name, :last_name, 
      :executor, :relation, :note, :id, :_destroy,
      address_attributes: [:id, :line_1, :postal_code, :city, :zone, :country_code ])
  end

end
