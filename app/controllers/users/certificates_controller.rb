module Users
  class CertificatesController < ApplicationController

    def show
      @user_certificate = UserCertificate.find(params[:id])
      @header = "#{@user_certificate.user.name} – "
                + "#{@user_certificate.certificate.title} "
    end

    def destroy
      @user_certificate = UserCertificate.find(params[:id])
      title = @user_certificate.title
      @user_certificate.destroy
      @user = User.find params[:user_id]
      redirect_to user_certificates_path(@user), notice: "#{title} er fjernet fra #{@user.name}"
    end

  end
end
