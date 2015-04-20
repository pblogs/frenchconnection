class DynamicFormsController < InheritedResources::Base

  def create
    Rails.logger.debug "in DynamicFormsController"
    @form = DynamicForm.new(dynamic_form_params)
    @form.save!
  end

  private


  def dynamic_form_params
    Rails.logger.debug "in dynamic_form_params"
    params.require(:dynamic_form).permit(:rows)
    #params.require(:rows).permit("rows")
  end
end

