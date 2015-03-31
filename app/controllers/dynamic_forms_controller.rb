class DynamicFormsController < InheritedResources::Base

  private

    def dynamic_form_params
      params.require(:dynamic_form).permit(:field_name, :populate, :autocomplete_from, :title)
    end
end

