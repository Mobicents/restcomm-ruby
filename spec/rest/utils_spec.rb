require 'spec_helper'

class UtilClass
  include Restcomm::REST::Utils
end

describe UtilClass do
  subject(:util) { UtilClass.new }

  it 'should convert a parameter name to a Restcomm-style name' do
    expect(util.restify('sms_url')).to eq('SmsUrl')
  end

  it 'should convert all parameter names to Restcomm-style names' do
    unrestified = {
      :sms_url => 'someUrl',
      'voiceFallbackUrl' => 'anotherUrl',
      'Status_callback' => 'yetAnotherUrl'
    }
    restified = {
      :SmsUrl => 'someUrl',
      :VoiceFallbackUrl => 'anotherUrl',
      :StatusCallback => 'yetAnotherUrl'
    }
    expect(util.restify(unrestified)).to eq(restified)
  end

  it 'should convert a Restcomm-style name to a parameter name' do
    expect(util.derestify('SmsUrl')).to eq('sms_url')
  end

  it 'should convert all Restcomm-style names to parameter names' do
    unrestified = {
      :sms_url => 'someUrl',
      :voice_fallback_url => 'anotherUrl',
      :status_callback => 'yetAnotherUrl'
    }
    restified = {
      :SmsUrl => 'someUrl',
      :VoiceFallbackUrl => 'anotherUrl',
      :StatusCallback => 'yetAnotherUrl'
    }
    expect(util.derestify(restified)).to eq(unrestified)
  end
end
