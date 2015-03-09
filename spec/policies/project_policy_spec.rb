require 'spec_helper'

describe ProjectPolicy do

  OWNER_ACTIONS = %W(update? edit? destroy?)
  GUEST_ACTIONS = %W(show? index?)
  WORKER_ACTIONS = %W()

  subject { described_class }

  context 'the owner' do
    let(:owner) { Fabricate(:user) }
    let(:project) { Fabricate(:project, user: owner) }

    OWNER_ACTIONS.each do |permission|
      permissions permission do

        it 'allow for owner' do
          expect(subject).to permit(owner, project)
        end

        it 'disallow for guest' do
          expect(subject).not_to permit(User.new, project)
        end
      end
    end

    GUEST_ACTIONS.each do |permission|
      permissions permission do
        it 'allow for owner' do
          expect(subject).to permit(owner, project)
        end

        it 'allow for guest' do
          expect(subject).to permit(User.new, project)
        end
      end
    end
  end

  context 'worker' do
    let(:project) { Fabricate(:project) }

    GUEST_ACTIONS.each do |permission|
      permissions permission do

        it "allow for guest" do
          expect(subject).to permit(User.new, project)
        end

      end
    end
  end

  context 'guest' do
    let(:project) { Fabricate(:project) }

    GUEST_ACTIONS.each do |permission|
      permissions permission do

        it "allow for guest" do
          expect(subject).to permit(User.new, project)
        end

      end
    end
  end
end

