require 'net/http'
require 'net/https'
require 'builder'
require 'json'
require 'rubygems'
require 'multi_json'
require 'cgi'
require 'openssl'
require 'base64'
require 'forwardable'
require 'jwt'

require 'restcomm-ruby/version' unless defined?(Restcomm::VERSION)
require 'restcomm-ruby/util'
require 'restcomm-ruby/util/configuration'
require 'restcomm-ruby/util/request_validator'
require 'restcomm-ruby/util/capability'
require 'restcomm-ruby/twiml/response'
require 'restcomm-ruby/task_router'
require 'restcomm-ruby/task_router/capability'
require 'restcomm-ruby/rest/errors'
require 'restcomm-ruby/rest/utils'
require 'restcomm-ruby/rest/list_resource'
require 'restcomm-ruby/rest/next_gen_list_resource'
require 'restcomm-ruby/rest/instance_resource'
require 'restcomm-ruby/rest/sandbox'
require 'restcomm-ruby/rest/accounts'
require 'restcomm-ruby/rest/calls'
require 'restcomm-ruby/rest/call_feedback'
require 'restcomm-ruby/rest/call_feedback_summary'
require 'restcomm-ruby/rest/sms'
require 'restcomm-ruby/rest/sms/short_codes'
require 'restcomm-ruby/rest/sms/messages'
require 'restcomm-ruby/rest/sip'
require 'restcomm-ruby/rest/sip/domains'
require 'restcomm-ruby/rest/sip/domains/ip_access_control_list_mappings'
require 'restcomm-ruby/rest/sip/domains/credential_list_mappings'
require 'restcomm-ruby/rest/sip/credential_lists'
require 'restcomm-ruby/rest/sip/credential_lists/credentials'
require 'restcomm-ruby/rest/sip/ip_access_control_lists'
require 'restcomm-ruby/rest/sip/ip_access_control_lists/ip_addresses'
require 'restcomm-ruby/rest/task_router/activities'
require 'restcomm-ruby/rest/task_router/events'
require 'restcomm-ruby/rest/task_router/reservations'
require 'restcomm-ruby/rest/task_router/task_queues'
require 'restcomm-ruby/rest/task_router/task_queues_statistics'
require 'restcomm-ruby/rest/task_router/tasks'
require 'restcomm-ruby/rest/task_router/workers'
require 'restcomm-ruby/rest/task_router/workers_statistics'
require 'restcomm-ruby/rest/task_router/workflow_statistics'
require 'restcomm-ruby/rest/task_router/workflows'
require 'restcomm-ruby/rest/task_router/workspaces'
require 'restcomm-ruby/rest/task_router/workspace_statistics'
require 'restcomm-ruby/rest/media'
require 'restcomm-ruby/rest/messages'
require 'restcomm-ruby/rest/applications'
require 'restcomm-ruby/rest/connect_apps'
require 'restcomm-ruby/rest/authorized_connect_apps'
require 'restcomm-ruby/rest/outgoing_caller_ids'
require 'restcomm-ruby/rest/incoming_phone_numbers'
require 'restcomm-ruby/rest/incoming_phone_numbers/local'
require 'restcomm-ruby/rest/incoming_phone_numbers/toll_free'
require 'restcomm-ruby/rest/incoming_phone_numbers/mobile'
require 'restcomm-ruby/rest/available_phone_numbers'
require 'restcomm-ruby/rest/available_phone_numbers/country'
require 'restcomm-ruby/rest/available_phone_numbers/local'
require 'restcomm-ruby/rest/available_phone_numbers/mobile'
require 'restcomm-ruby/rest/available_phone_numbers/toll_free'
require 'restcomm-ruby/rest/conferences'
require 'restcomm-ruby/rest/conferences/participants'
require 'restcomm-ruby/rest/queues'
require 'restcomm-ruby/rest/queues/members'
require 'restcomm-ruby/rest/usage'
require 'restcomm-ruby/rest/usage/records'
require 'restcomm-ruby/rest/usage/triggers'
require 'restcomm-ruby/rest/recordings'
require 'restcomm-ruby/rest/transcriptions'
require 'restcomm-ruby/rest/tokens'
require 'restcomm-ruby/rest/notifications'
require 'restcomm-ruby/rest/addresses'
require 'restcomm-ruby/rest/addresses/dependent_phone_numbers'
require 'restcomm-ruby/rest/client'
require 'rack/restcomm_webhook_authentication'

module Restcomm
  extend SingleForwardable

  def_delegators :configuration, :account_sid, :auth_token

  ##
  # Pre-configure with account SID and auth token so that you don't need to
  # pass them to various initializers each time.
  def self.configure(&block)
    yield configuration
  end

  ##
  # Returns an existing or instantiates a new configuration object.
  def self.configuration
    @configuration ||= Util::Configuration.new
  end
  private_class_method :configuration
end
