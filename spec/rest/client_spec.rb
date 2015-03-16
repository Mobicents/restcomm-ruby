require 'spec_helper'

describe Restcomm::REST::Client do
  describe 'config at class level' do
    after(:each) do
      Restcomm.instance_variable_set('@configuration', nil)
    end

    it 'should set the account sid and auth token with a config block' do
      Restcomm.configure do |config|
        config.account_sid = 'someSid'
        config.auth_token = 'someToken'
      end

      client = Restcomm::REST::Client.new
      expect(client.account_sid).to eq('someSid')
      expect(client.instance_variable_get('@auth_token')).to eq('someToken')
    end

    it 'should overwrite account sid and auth token if passed to initializer' do
      Restcomm.configure do |config|
        config.account_sid = 'someSid'
        config.auth_token = 'someToken'
      end

      client = Restcomm::REST::Client.new 'otherSid', 'otherToken'
      expect(client.account_sid).to eq('otherSid')
      expect(client.instance_variable_get('@auth_token')).to eq('otherToken')
    end

    it 'should overwrite the account sid if only the sid is given' do
      Restcomm.configure do |config|
        config.account_sid = 'someSid'
        config.auth_token = 'someToken'
      end

      client = Restcomm::REST::Client.new 'otherSid'
      expect(client.account_sid).to eq('otherSid')
      expect(client.instance_variable_get('@auth_token')).to eq('someToken')
    end

    it 'should allow options after setting up auth with config' do
      Restcomm.configure do |config|
        config.account_sid = 'someSid'
        config.auth_token = 'someToken'
      end

      client = Restcomm::REST::Client.new :host => 'api.fakerestcomm.com'

      connection = client.instance_variable_get('@connection')
      expect(connection.address).to eq('api.fakerestcomm.com')
    end

    it 'should throw an argument error if the sid and token isn\'t set' do
      expect { Restcomm::REST::Client.new }.to raise_error(ArgumentError)
    end

    it 'should throw an argument error if only the account_sid is set' do
      expect { Restcomm::REST::Client.new 'someSid' }.to raise_error(ArgumentError)
    end
  end

  it 'should not raise an error if the response body is empty' do
    FakeWeb.register_uri(:any, %r/api\.restcomm\.com/, body: '')
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    Restcomm::REST::IncomingPhoneNumber.new('/phone_number', restcomm).delete
  end

  it 'should not raise an error if the response body is nil' do
    response = double(:response, body: nil)
    connection = double(:connection, request: response)
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    restcomm.instance_variable_set(:@connection, connection)
    Restcomm::REST::IncomingPhoneNumber.new('/phone_number', restcomm).delete
  end

  it 'should set up a new client instance with the given sid and token' do
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    expect(restcomm.account_sid).to eq('someSid')
    expect(restcomm.instance_variable_get('@auth_token')).to eq('someToken')
  end

  it 'should set up the proper default http ssl connection' do
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.address).to eq('api.restcomm.com')
    expect(connection.port).to eq(443)
    expect(connection.use_ssl?).to eq(true)
  end

  it 'should set up the requested ssl verification ca_file if provided' do
    restcomm = Restcomm::REST::Client.new(
      'someSid', 'someToken', ssl_ca_file: '/path/to/ca/file'
    )
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.ca_file).to eq('/path/to/ca/file')
  end

  it 'should set up the proper http ssl connection when a different ' \
     'domain is given' do
    restcomm = Restcomm::REST::Client.new(
      'someSid', 'someToken', host: 'api.fakerestcomm.com'
    )
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.address).to eq('api.fakerestcomm.com')
    expect(connection.port).to eq(443)
    expect(connection.use_ssl?).to eq(true)
  end

  it 'should adjust the open and read timeouts on the underlying Net::HTTP ' \
     'object when asked' do
    timeout = rand(30)
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken', timeout: timeout)
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.port).to eq(443)
    expect(connection.use_ssl?).to eq(true)
    expect(connection.open_timeout).to eq(timeout)
    expect(connection.read_timeout).to eq(timeout)
  end

  it 'should set up the proper http ssl connection when a proxy_host is ' \
     'given' do
    restcomm = Restcomm::REST::Client.new(
      'someSid',
      'someToken',
      host: 'api.fakerestcomm.com',
      proxy_addr: 'localhost'
    )
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.proxy?).to eq(true)
    expect(connection.proxy_address).to eq('localhost')
    expect(connection.proxy_port).to eq(80)
    expect(connection.address).to eq('api.fakerestcomm.com')
    expect(connection.port).to eq(443)
    expect(connection.use_ssl?).to eq(true)
  end

  it 'should set up the proper http ssl connection when a proxy_host and ' \
     'proxy_port are given' do
    restcomm = Restcomm::REST::Client.new(
      'someSid',
      'someToken',
      host: 'api.fakerestcomm.com',
      proxy_addr: 'localhost',
      proxy_port: 13128
    )
    connection = restcomm.instance_variable_get('@connection')
    expect(connection.proxy?).to eq(true)
    expect(connection.proxy_address).to eq('localhost')
    expect(connection.proxy_port).to eq(13128)
    expect(connection.address).to eq('api.fakerestcomm.com')
    expect(connection.port).to eq(443)
    expect(connection.use_ssl?).to eq(true)
  end

  it 'should set up an accounts resources object' do
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    expect(restcomm).to respond_to(:accounts)
    expect(restcomm.accounts.instance_variable_get('@path')).to eq(
      '/2010-04-01/Accounts'
    )
  end

  it 'should set up an account object with the given sid' do
    restcomm = Restcomm::REST::Client.new('someSid', 'someToken')
    expect(restcomm).to respond_to(:account)
    expect(restcomm.account.instance_variable_get('@path')).to eq(
      '/2010-04-01/Accounts/someSid'
    )
  end

  [
      :sandbox, :available_phone_numbers, :incoming_phone_numbers,
      :calls, :outgoing_caller_ids, :conferences, :sms, :recordings,
      :transcriptions, :notifications, :applications, :connect_apps,
      :authorized_connect_apps, :queues, :usage, :messages, :media, :sip
  ].each do |method|
    it "should delegate the client method #{method} to the account object" do
      client = Restcomm::REST::Client.new('someSid', 'someToken')
      expect(client).to respond_to(method)
      expect(client.send(method)).to eq(client.account.send(method))
    end
  end

  it 'should throw an argument error if the workspace_sid is not set' do
    expect { Restcomm::REST::TaskRouterClient.new 'someSid', 'someToken' }.to raise_error(ArgumentError)
  end

  it 'should have its host set to taskrouter.restcomm.com' do
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    connection = client.instance_variable_get('@connection')
    expect(connection.address).to eq('taskrouter.restcomm.com')
  end

  it 'should have task queue statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:task_queue_statistics)
    expect(client.task_queue_statistics('someSid').instance_variable_get('@path')).to eq('/v1/Workspaces/someSid/TaskQueues/someSid/Statistics')
  end

  it 'should have task queues statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{"meta": {"key": "task_queues_statistics"}, "task_queues_statistics": [{"task_queue_sid": "WQ123"}]}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:task_queues_statistics)
    expect(client.task_queues_statistics[0].task_queue_sid).to eq('WQ123')
  end

  it 'should have worker statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:worker_statistics)
    expect(client.worker_statistics('someSid').instance_variable_get('@path')).to eq('/v1/Workspaces/someSid/Workers/someSid/Statistics')
  end

  it 'should have workers statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:workers_statistics)
    expect(client.workers_statistics.instance_variable_get('@path')).to eq('/v1/Workspaces/someSid/Workers/Statistics')
  end

  it 'should have workflow statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:workflow_statistics)
    expect(client.workflow_statistics('someSid').instance_variable_get('@path')).to eq('/v1/Workspaces/someSid/Workflows/someSid/Statistics')
  end

  it 'should have workspace statistics resource' do
    FakeWeb.register_uri(:get, %r/taskrouter\.restcomm\.com/, body: '{}')
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:workspace_statistics)
    expect(client.workspace_statistics.instance_variable_get('@path')).to eq('/v1/Workspaces/someSid/Statistics')
  end

  it 'should set up a workspaces resource object' do
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:workspaces)
    expect(client.workspaces.instance_variable_get('@path')).to eq('/v1/Workspaces')
  end

  it 'should set up a workspace resource object' do
    client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
    expect(client).to respond_to(:workspace)
    expect(client.workspace.instance_variable_get('@path')).to eq('/v1/Workspaces/someSid')
  end

  [
      :activities, :tasks, :task_queues, :workers, :workflows
  ].each do |method|
    it "should delegate the client method #{method} to the workspace object" do
      client = Restcomm::REST::TaskRouterClient.new('someSid', 'someToken', 'someSid')
      expect(client).to respond_to(method)
      expect(client.send(method)).to eq(client.workspace.send(method))
    end
  end
end
