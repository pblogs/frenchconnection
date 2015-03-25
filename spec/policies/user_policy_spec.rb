require 'spec_helper'

describe UserPolicy do

  ADMIN_ACTIONS = %W(update? edit? destroy? new? create?)
  USER_ACTIONS = %W(show? index? update_basic_info?)

  subject { described_class }

  context 'admin' do
    let(:admin) { Fabricate(:user, roles: [:admin]) }
    let(:user) { Fabricate(:user) }

    ADMIN_ACTIONS.each do |permission|
      permissions permission do

        it 'allow for admin' do
          expect(subject).to permit(admin, user)
        end

        it 'disallow for the user' do
          expect(subject).not_to permit(user, user)
        end
      end
    end

    USER_ACTIONS.each do |permission|
      permissions permission do
        it 'allow for admin' do
          expect(subject).to permit(admin, user)
        end

        it 'allow for the user' do
          user = User.new
          expect(subject).to permit(user, user)
        end
      end
    end
  end

  context 'worker' do

    USER_ACTIONS.each do |permission|
      permissions permission do

        it "allow for the user" do
          user = User.new
          expect(subject).to permit(user, user)
        end

      end
    end
  end

  context 'the user' do

    USER_ACTIONS.each do |permission|
      permissions permission do

        it "allow for the user" do
          user = User.new
          expect(subject).to permit(user, user)
        end

      end
    end
  end
end

