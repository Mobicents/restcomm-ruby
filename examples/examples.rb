#Welcomme to Restcomm 
#The examples below will help you get started using Restcomm-ruby wraper
# examples version 1.2.0
# You must make sure the @account_sid, @auth_token and @host variables are correctly filled
#
#The @host is the IP address on which Restcomm is running (This could be a local install or a remote)
#
#
#
####### Account Settings #########

require 'restcomm-ruby'



@account_sid = 'ACae6e420f425248d6a26948c17a9e2acf'
@auth_token = 'YourPassWord' #
@host = '192.168.1.3'  #IP address of your Restcomm instance  
# set up a client
@client = Restcomm::REST::Client.new(@account_sid, @auth_token, @host)

################ ACCOUNTS ################

# shortcut to grab your account object (account_sid is inferred from the client's auth credentials)
@account = @client.account

#list of all accounts and (sub)accounts
	@client.accounts.list.each do |x|
	puts "Account name: " + x.friendly_name + "      Account Sid: " + x.sid 
	end

# grab an account instance resource of a given account and display the friendly_name
	puts @client.accounts.get(@account_sid).friendly_name

# grab an account instance resource of a given account and display the sid
	puts @client.accounts.get(@account_sid).sid

# update an account's friendly name
@client.accounts.get(@account_sid).update(friendly_name: 'A Super Cool Name')


################ CALLS ################

	
# print a list of calls (without parameters)
	 @account.calls.list().each do |x|
	 puts "Call Sid " + x.sid + "      Call Status: " + x.status 
	 end


# print a list of calls (with some optional parameters)

@account.calls.list(page: 0, page_size: 1000,).each do |x|
  puts x.sid
end

# get a particular call and list its status
puts @account.calls.get('CAb358e7b349924ece8a968f7089222039').status

# get a particular call and list its start time
puts @account.calls.get('CAb358e7b349924ece8a968f7089222039').start_time

# get a particular call and list its recording URI
puts @account.calls.get('CAb358e7b349924ece8a968f7089222039').subresource_uris["recordings"]

#################### RECORDINGS ##################################

#get a list of recordings linked to the current account and output the call SID and date created
@account.recordings.list.each do |x|
  puts "Recording SID: " + x.call_sid + " **** " + "Date Created: " + x.date_created
end


#get a list of recordings URLs with ext .wav 
#use ext .mp3 to get the corresponding  mp3 list
@account.recordings.list.each do |r|
  puts r.wav
end



#################### MAKING CALLS ##################################

# make a new outgoing call. returns a call object just like calls.get
@call = @account.calls.create(
  from: 'sip:+32145687',
  to: 'sip:+1111@192.168.1.3',
  url: 'http://192.168.1.3:8080/restcomm-rvd/services/apps/test/controller'
)


# cancel the call if not already in progress
@account.calls.get(@call.sid).update(status: 'canceled')
# or equivalently
@call.update(status: 'canceled')



####### Terminate a call that is currently in-progress ########

@account.calls.get(@call.sid).update(status: 'completed')



# redirect and then terminate a call

@call.update(url: 'http://192.168.1.3:8080/restcomm/demos/hello-play.xml')
@call.update(status: 'completed')
# or, use the aliases...
@call.redirect_to('http://192.168.1.3:8080/restcomm/demos/hello-play.xml')
@call.hangup

################ SMS MESSAGES ################

# print a list of messages
@account.messages.list(date_sent: '2010-09-01').each do |message|
  puts message.body
end

# print a particular sms message
puts @account.messages.get('SMXXXXXXXX').body

# send an sms
@account.messages.create(
  from: '+14159341234',
  to: '+16105557069',
  body: 'Hey there!'
)

# send an mms the from DID should be a number from your  DID provider
@account.messages.create(
  from: '+14159341234',
  to: '+16105557069',
  media_urls: 'http://example.com/media.png'
)

################ PHONE NUMBERS ################

# get a list of supported country codes
@account.available_phone_numbers.list

# print some available numbers
@numbers = @account.available_phone_numbers.get('US').local.list(
  AreaCode: '305'
)

@numbers.each { |num| puts num.phone_number }

# buy the first one
@account.incoming_phone_numbers.create(phone_number: @numbers[0].phone_number)

# update an existing phone number's voice url
number = @account.incoming_phone_numbers.get('PNdba508c5616a7f5e141789f44f022cc3')
number.update(voice_url: 'http://example.com/voice')

# decommission an existing phone number
numbers = @account.incoming_phone_numbers.list(
  friendly_name: 'A Fabulous Friendly Name'
)
numbers[0].delete
################ CONFERENCES  ################

# get a particular conference's participants object and stash it
conference = @account.conferences.get('CFbbe46ff1274e283f7e3ac1df0072ab39')
@participants = conference.participants

# list participants
@participants.list.each do |p|
  puts p.sid
end

# update a conference participant
@participants.get('CA386025c9bf5d6052a1d1ea42b4d16662').update(muted: 'true')
# or an easier way
@participants.get('CA386025c9bf5d6052a1d1ea42b4d16662').mute

# and, since we're lazy loading, this would only incur one http request
@account.conferences.get('CFbbe46ff1274e283f7e3ac1df0072ab39').participants
  .get('CA386025c9bf5d6052a1d1ea42b4d16662').update(muted: 'true')

################ QUEUES ###################

# create a new queue
@queue = @account.queues.create(friendly_name: 'MyQueue', max_size: 50)

# get a list of queues for this account
@queues = @account.queues.list

# get a particular queue and its members
@queue = @account.queues.get("QQb6765b0458714964970a73dcaf55efd1")
@members = @queue.members

#list members
@members.list.each do |m|
  puts m.wait_time
end

# dequeue a particular user and run twiml at a specific url
@member = @members.get('CA386025c9bf5d6052a1d1ea42b4d16662')
@member.dequeue('http://myapp.com/deque')
