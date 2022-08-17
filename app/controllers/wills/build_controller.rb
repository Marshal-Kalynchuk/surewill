class Wills::BuildController < ApplicationController
  include Wicked::Wizard
  before_action :authenticate_user!
  before_action :set_will, except: :create
  #before_action :set_progress, only: :show

  steps :add_testator, :add_delegates, :add_assets

  def show
    case step
    when :add_testator
      @will.build_testator unless @will.testator
    when :add_delegates
      if @will.delegates.empty?
        @delegate = @will.delegates.build 
      end
      @delegates = @will.delegates

    when :add_executors
      @delegates = @will.delegates
      @will.executors.build if @will.executors.empty?
    when :add_beneficiaries
      @delegates = @will.delegates
      @will.beneficiaries.build if @will.beneficiaries.empty?
    when :add_assets
      @beneficiaries = @will.beneficiaries
      @will.assets.build.bequests.build if @will.assets.empty?
    when :add_bequests
      @beneficiaries = @will.beneficiaries
      @assets = @will.assets
      @will.bequests.build if @will.bequests.empty?
    end
    render_wizard
  end

  def update
    params[:will][:status] = step.to_s
    params[:will][:status] = 'active' if step == steps.last
    if @will.update(will_params)
      render_wizard @will
    else
      render_wizard @will, status: :unprocessable_entity
    end
  end

  def create
    @will = current_user.create_will
    redirect_to wizard_path(steps.first)
  end

  private

    def set_will
      @will = current_user.will
    end

    # def set_progress
    #   if wizard_steps.any? && wizard_steps.index(step).present?
    #     @progress = ((wizard_steps.index(step) + 1).to_d / wizard_steps.count.to_d) * 100
    #   else
    #     @progress = 0
    #   end
    # end

    def will_params
      params.require(:will).permit(
        :user_id, :status, testator_attributes: [ :first_name, :middle_name, :last_name, :id ],
      )
    end
end
