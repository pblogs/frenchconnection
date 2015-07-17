require 'spec_helper'

describe ProjectPolicy do

  PROJECT_LEAD_ACTIONS = %W(update? edit? create? destroy? complete?)
  GUEST_ACTIONS = %W(show? index?)

  subject { described_class }

  context 'project lead and admin' do
    let(:project_lead) { Fabricate(:user, roles: [:project_leader]) }
    let(:project) { Fabricate(:project, user: project_lead) }

    PROJECT_LEAD_ACTIONS.each do |permission|
      permissions permission do

        it 'allow for project_lead' do
          expect(subject).to permit(project_lead, project)
        end

        it 'disallow for guest' do
          expect(subject).not_to permit(User.new, project)
        end
      end
    end

    GUEST_ACTIONS.each do |permission|
      permissions permission do
        it 'allow for project_lead' do
          expect(subject).to permit(project_lead, project)
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

