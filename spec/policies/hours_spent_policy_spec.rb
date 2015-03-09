require 'spec_helper'

describe HoursSpentPolicy do

  ACTIONS = %W(update? edit? destroy?)
  PROJECT_LEADER_ACTIONS = %W(approve?)

  subject { described_class }

  context 'personal hours' do
    let(:owner) { Fabricate(:user) }
    let(:project_leader) { Fabricate(:user, roles: [:project_leader]) }
    let(:hours_spent) { Fabricate(:hours_spent, of_kind: :personal, user: owner) }

    ACTIONS.each do |permission|
      permissions permission do

        it 'allow for the worker that has registered the hour' do
          expect(subject).to permit(owner, hours_spent)
        end

        it 'disallow for project_leader' do
          expect(subject).not_to permit(project_leader, hours_spent)
        end

        it 'disallow for everyone else' do
          expect(subject).not_to permit(User.new, hours_spent)
        end
      end
    end
  end

  context 'billable hours' do
    let(:owner) { Fabricate(:user) }
    let(:project_leader) { Fabricate(:user, roles: [:project_leader]) }
    let(:hours_spent) { Fabricate(:hours_spent, of_kind: :billable, user: owner) }

    ACTIONS.each do |permission|
      permissions permission do

        it 'disallow for the worker that has registered the hour' do
          expect(subject).not_to permit(owner, hours_spent)
        end

        it 'allow for project_leader' do
          expect(subject).to permit(project_leader, hours_spent)
        end

        it 'disallow for everyone else' do
          expect(subject).not_to permit(User.new, hours_spent)
        end
      end
    end
  end

  context 'billable and personal hours that is approved' do
    let(:owner) { Fabricate(:user) }
    let(:project_leader) { Fabricate(:user, roles: [:project_leader]) }
    let(:hours_spent) { Fabricate(:hours_spent, of_kind: :billable,
                                  user: owner, approved: true) }

    ACTIONS.each do |permission|
      permissions permission do

        it 'disallow for the worker that has registered the hour' do
          expect(subject).not_to permit(owner, hours_spent)
        end

        it 'disallow for project_leader' do
          expect(subject).not_to permit(project_leader, hours_spent)
        end

        it 'disallow for everyone else' do
          expect(subject).not_to permit(User.new, hours_spent)
        end
      end
    end
  end

end

