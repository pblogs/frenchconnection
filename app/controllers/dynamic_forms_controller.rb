class DynamicFormsController < ApplicationController

  def new
  end

  def create
    Rails.logger.debug  "rows: #{params['rows']}"
    Rails.logger.debug  "form_title: #{params['form_title']}"
    @form = @current_user
              .dynamic_forms.new(title: params[:form_title],
                                 rows:  params[:rows]
                                )
    @form.save!
    render nothing: true
  end

  def index
    @dynamic_forms = @current_user.dynamic_forms.all
  end

  def destroy
    @form = @current_user.dynamic_forms.find(params[:id])
    @form.destroy
    redirect_to dynamic_forms_path
  end

  private


  def dynamic_form_params
    Rails.logger.debug "in dynamic_form_params"
    params.require(:dynamic_form).permit(:rows)
  end
end

