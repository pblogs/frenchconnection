require 'spec_helper'

describe Skill do
  context 'a Task requires certain skills to be completed' do
    let(:welding)  { Fabricate(:skill, title: 'welding') }
    let(:painting) { Fabricate(:skill, title: 'painting') }
    let(:task) { Fabricate(:task, skills: [welding, painting]) }

    describe 'relationships' do
      it 'belongs to a task' do
        task.skills.should eq [welding, painting]
      end
    end

  end
end
