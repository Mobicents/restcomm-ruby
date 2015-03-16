require 'spec_helper'

describe Restcomm::REST::Token do
  before do
    @token = Restcomm::REST::Token.new('someUri', 'someClient')
  end
end
