require 'spec_helper'

describe Restcomm::REST::Queue do
  it 'should set up a members resources object' do
    queue = Restcomm::REST::Queue.new('someUri', 'someClient')
    expect(queue).to respond_to(:members)
    expect(queue.members.instance_variable_get('@path')).to eq(
      'someUri/Members'
    )
  end
end
