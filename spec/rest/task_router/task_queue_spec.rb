require 'spec_helper'

describe Restcomm::REST::TaskRouter::TaskQueues do
  it 'creates a task queue object' do
    workspace = Restcomm::REST::TaskRouter::Workspace.new('someUri', 'someClient')
    expect(workspace).to respond_to(:task_queues)
    expect(workspace.task_queues.instance_variable_get('@path')).to eq('someUri/TaskQueues')
  end
end
