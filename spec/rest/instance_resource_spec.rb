require 'spec_helper'

describe Restcomm::REST::InstanceResource do
  it 'should set up an internal reference to the uri and client' do
    resource = Restcomm::REST::InstanceResource.new('some/uri', 'someClient')
    expect(resource.instance_variable_get('@path')).to eq('some/uri')
    expect(resource.instance_variable_get('@client')).to eq('someClient')
  end

  it 'should set up object properties if passed' do
    params = { 'SomeKey' => 'someValue' }
    resource = Restcomm::REST::InstanceResource.new('uri', 'client', params)
    expect(resource.some_key).to eq('someValue')
  end
end
