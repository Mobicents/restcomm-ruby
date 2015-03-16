describe Restcomm do
  after(:each) do
    Restcomm.instance_variable_set('@configuration', nil)
  end

  it 'should set the account sid and auth token with a config block' do
    Restcomm.configure do |config|
      config.account_sid = 'someSid'
      config.auth_token = 'someToken'
    end

    expect(Restcomm.account_sid).to eq('someSid')
    expect(Restcomm.auth_token).to eq('someToken')
  end
end
