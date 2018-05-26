


[Try Restcomm Cloud NOW for FREE!](https://www.restcomm.com/sign-up/) Zero download and install required.


All Restcomm [docs](https://www.restcomm.com/docs/) and [downloads](https://www.restcomm.com/downloads/) are now available at [Restcomm.com](https://www.restcomm.com).




[![Gem Version](http://img.shields.io/gem/v/restcomm-ruby.svg)][gem]
[![Build Status](http://img.shields.io/travis/restcomm/restcomm-ruby.svg)][travis]
[![Code Quality](http://img.shields.io/codeclimate/github/restcomm/restcomm-ruby.svg)][codeclimate]

# restcomm-ruby

A module for using the Restcomm REST API and generating valid [RCML](http://docs.telestax.com/restcomm-pages/ "RCML - Restcomm Markup Language"). [Click here to read the full documentation.][documentation]

## Installation

To install using [Bundler][bundler] grab the latest stable version:

```ruby
gem 'restcomm-ruby', '~> 1.2.0'
```

To manually install `restcomm-ruby` via [Rubygems][rubygems] simply gem install:

```bash
gem install restcomm-ruby
```

To build and install the development branch yourself from the latest source:

```bash
git clone git@github.com:Mobicents/restcomm-ruby.git
cd restcomm-ruby
make install
```

## Getting Started With REST

### Setup Work

``` ruby
require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'restcomm-ruby'

# put your own credentials here
account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
host = 'IP_ADDRESS_RESTCOMM_INSTANCE'

# set up a client to talk to the Restcomm REST API
@client = Restcomm::REST::Client.new account_sid, auth_token, host



# and then you can create a new client without parameters
@client = Restcomm::REST::Client.new
```

### Send an SMS

``` ruby
@client.messages.create(
  from: '+14159341234',
  to: '+16105557069',
  body: 'Hey there!'
)
```



### Do Some Stuff With Calls

``` ruby
# make a new outgoing call
@call = @client.calls.create(
  from: 'sip:+14159341234',
  to: 'sip:+18004567890',
  url: 'http://example.com/call-handler'
)

# hangup a ringing call, but don't touch it if it's connected
@call.cancel

# if you have the call sid, you can fetch a call object via:
@call = @client.calls.get('CA386025c9bf5d6052a1d1ea42b4d16662')

# redirect an in-progress call
@call.redirect_to('http://example.com/call-redirect')

# hangup a call, no matter whether it is ringing or connected
@call.hangup
```

### List Calls after a certain time

``` ruby
# list calls made or received on or after May 13, 2013
@client.calls.list("start_time>" => "2013-05-13") # Notice we omit the "=" in the "start_time>=" parameter because it is automatically added
```



## Getting Started With RCML

RCML support is based on the [Builder][builder] library. You can construct a
RCML response like this:

``` ruby
require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'restcomm-ruby'

# build up a response
response = Restcomm::RCML::Response.new do |r|
  r.Say 'hello there', voice: 'alice'
  r.Dial callerId: '+14159992222' do |d|
    d.Client 'jenny'
  end
end

# print the result
puts response.text
```

This will print the following (except for the whitespace):

``` xml
<?xml version="1.0" encoding="UTF-8"?>
<Response>
  <Say voice="alice">hello there</Say>
  <Dial callerId="+14159992222">
    <Client>jenny</Client>
  </Dial>
</Response>
```

## Supported Ruby Versions

This library supports and is [tested against][travis] the following Ruby
implementations:

- Ruby 1.9.3 and above
- [JRuby][jruby]
- [Rubinius][rubinius]

## More Information

There are more detailed examples in the included [examples][examples]
directory. Also for thoose upgrading, the [upgrade guide][upgrade] is available in the [restcomm-ruby github wiki][wiki].

[capability]: https://github.com/Mobicents/restcomm-ruby/wiki/Capability
[builder]: http://builder.rubyforge.org/
[examples]: https://github.com/restcomm/restcomm-ruby/blob/master/examples
[documentation]: http://restcomm-ruby.readthedocs.org/en/latest
[upgrade]: https://github.com/restcomm/restcomm-ruby/wiki/UpgradeGuide
[wiki]: https://github.com/restcomm/restcomm-ruby/wiki
[bundler]: http://bundler.io
[rubygems]: http://rubygems.org
[gem]: https://rubygems.org/gems/restcomm
[codeclimate]: https://codeclimate.com/github/restcomm/restcomm-ruby
[jruby]: http://www.jruby.org
[rubinius]: http://rubini.us
