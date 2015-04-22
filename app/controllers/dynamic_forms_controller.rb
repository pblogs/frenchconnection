class DynamicFormsController < ApplicationController

  def new
  end

  def create
    Rails.logger.debug  "rows: #{params[:rows]}"
    Rails.logger.debug  "form_title: #{params[:rows][:form_title]}"
    @form = @current_user
              .dynamic_forms.new(title: params[:rows][:form_title],
                                 rows:  params[:rows]
                                )
    @form.save!
    render json: dynamic_forms_path, status: :ok
  end

  def index
    @dynamic_forms = @current_user.dynamic_forms.all
  end

  def destroy
    @form = @current_user.dynamic_forms.find(params[:id])
    @form.destroy
    redirect_to dynamic_forms_path(format: :html)

  end

  private


  def dynamic_form_params
    Rails.logger.debug "in dynamic_form_params"
    params.require(:dynamic_form).permit(:rows)
  end
end

