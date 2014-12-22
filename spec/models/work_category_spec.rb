require 'spec_helper'

describe WorkCategory do
  let(:welding) { Fabricate(:work_category, title: 'Welding')  }
  let(:task1) { Fabricate(:task, work_category: welding, 
                          description: 'Welding outdoor')  }
  let(:task2) { Fabricate(:task, work_category: welding, 
                          description: 'Welding more outdoor')  }

  it 'has many tasks' do
    welding.tasks.should eq [task1, task2]
  end
end
