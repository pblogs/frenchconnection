require 'spec_helper'

describe TaskPolicy do

  # A project has one or more tasks. When a task is delegated to a User, we create a
  # UserTask. This is the object he works with. The Task object itself is
  # only touched by the Project leader.


  PROJECT_LEAD_ACTIONS = %W(create? destroy? edit?
    qualified_workers? remove_selected_inventory?
    remove_selected_worker? save_and_order_resources? select_inventory?
    select_workers? selected_inventories? selected_workers? update?)
  GUEST_ACTIONS = %W(active? index? report? show? inventories? )

  subject { described_class }

  context 'project lead, admin and guest' do
    let(:project_lead) { Fabricate(:user, roles: [:project_leader]) }
    let(:task_owner)   { Fabricate(:user) }
    let(:task)         { Fabricate(:task) }
    let(:guest)        { Fabricate(:user) }

    PROJECT_LEAD_ACTIONS.each do |permission|
      permissions permission do

        it 'allow for project_lead' do
          expect(subject).to permit(project_lead, task)
        end

        it 'disallow for guest' do
          expect(subject).not_to permit(User.new, task)
        end

      end
    end


    GUEST_ACTIONS.each do |permission|
      permissions permission do
        it 'allow for project_lead' do
          expect(subject).to permit(project_lead, task)
        end

        it 'allow for guest' do
          expect(subject).to permit(guest, task)
        end
      end
    end
  end

end
