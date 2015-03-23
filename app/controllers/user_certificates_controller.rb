class UserCertificatesController < ApplicationController

  def show
    @user_certificate = UserCertificate.find(params[:id])
    @header = "#{@user_certificate.user.name} – #{@user_certificate.certificate.title} "
  end
end
