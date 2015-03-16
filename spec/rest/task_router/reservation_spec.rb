require 'spec_helper'

describe Restcomm::REST::TaskRouter::Reservations do
  it 'creates a reservation object' do
    task = Restcomm::REST::TaskRouter::Task.new('someUri', 'someClient')
    expect(task).to respond_to(:reservations)
    expect(task.reservations.instance_variable_get('@path')).to eq('someUri/Reservations')
  end
end
