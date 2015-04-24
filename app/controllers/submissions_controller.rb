class SubmissionsController < ApplicationController

  def create
    @submission = @current_user.submissions.new(values: params[:values],
                                                dynamic_form_id: params[:dynamic_form_id])
    if @submission.save!
      render json: dynamic_forms_path, status: :ok
    else
      render json: dynamic_form_path(@params[:dynamic_form_id]), status: :error
    end
  end

  def show
    @submission = Submission.find params[:id]
    respond_to do |format|
      format.html
      format.json { render json: {user_id: @submission.user_id,
                                  title:   @submission.dynamic_form.title,
                                  values: @submission.values } }
    end
  end

  private

  def submission_params
    params.require(:submission).permit(:values, :dynamic_form_id, :user_id)
  end

end

