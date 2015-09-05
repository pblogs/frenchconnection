class SettingsController < ApplicationController
  def projects
    @settings = Setting.first_or_create
  end


  def show
  end

  def edit
  end
  def update
    @settings = Setting.first
    respond_to do |format|
      if @settings.update(settings_params)
        format.html { redirect_to :back, notice: t('updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @settings.errors,
                      status: :unprocessable_entity }
      end
    end
  end

  private
  def settings_params
    params.require(:settings).permit(
      :project_numbers,
      :enable_project_reference_field
    )
  end
end
