require 'spec_helper'

describe Restcomm::REST::FeedbackSummary do
  it 'creates a feedback summary object' do
    calls = Restcomm::REST::Calls.new('someUri', 'someClient')
    expect(calls).to respond_to(:feedback_summary)
    expect(calls.feedback_summary.instance_variable_get('@path')).to eq('someUri/FeedbackSummary')
  end
end
