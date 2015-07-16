require 'spec_helper'

describe UserTaskPolicy do

  USER_ACTIONS = %W(confirm_user_task?)

  subject { described_class }

  context 'the user' do
    let(:guest) { Fabricate(:user) }
    let(:user) { Fabricate(:user) }
    let(:task) { Fabricate(:user_task, user: user) }

    USER_ACTIONS.each do |permission|
      permissions permission do

        it 'allowed' do
          expect(subject).to permit(user, task)
        end

        it 'disallow for guest' do
          expect(subject).not_to permit(guest, task)
        end
      end
    end
  end
end
