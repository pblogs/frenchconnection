require 'spec_helper'

describe CertificatePolicy do

  ADMIN_ACTIONS = %W(update? edit? destroy? new? create?)
  GUEST_ACTIONS = %W(show? index?)

  subject { described_class }

  context 'project leader or admin' do
    let(:admin) { Fabricate(:user, roles: [:admin]) }
    let(:certificate) { Fabricate(:certificate) }

    ADMIN_ACTIONS.each do |permission|
      permissions permission do

        it 'allow for admin' do
          expect(subject).to permit(admin, certificate)
        end

        it 'disallow for guest' do
          expect(subject).not_to permit(User.new, certificate)
        end
      end
    end

    GUEST_ACTIONS.each do |permission|
      permissions permission do
        it 'allow for admin' do
          expect(subject).to permit(admin, certificate)
        end

        it 'allow for guest' do
          expect(subject).to permit(User.new, certificate)
        end
      end
    end
  end

  context 'worker' do
    let(:certificate) { Fabricate(:certificate) }

    GUEST_ACTIONS.each do |permission|
      permissions permission do

        it "allow for guest" do
          expect(subject).to permit(User.new, certificate)
        end

      end
    end
  end

  context 'guest' do
    let(:certificate) { Fabricate(:certificate) }

    GUEST_ACTIONS.each do |permission|
      permissions permission do

        it "allow for guest" do
          expect(subject).to permit(User.new, certificate)
        end

      end
    end
  end
end

