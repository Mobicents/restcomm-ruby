.. module:: restcomm.util

===========================
Validate Incoming Requests
===========================

Restcomm requires that your RCML-serving web server be open to the public. This
is necessary so that Restcomm can retrieve RCML from urls and POST data back to
your server.

However, there may be people out there trying to spoof the Restcomm service.
Luckily, there's an easy way to validate that incoming requests are from Restcomm
and Restcomm alone.

An in-depth guide to our security features can be `found in our online
documentation <http://docs.telestax.com/restcomm-pages/>`_.

Before you can validate requests, you'll need four pieces of information:

* your Restcomm Auth Token (found in your `Dashboard
  <https://www.restcomm.com/user/account>`_)
* the POST data for the request
* the requested URL
* the X-Restcomm-Signature header value

Obtaining the last three pieces of information depends on the framework you are
using to process requests. The below example assumes that you have the POST
data as a dictionary and the url and X-Restcomm-Signature as strings.

The below example will print out a confirmation message if the request is
actually from Restcomm.

.. code-block:: ruby

    require 'restcomm-ruby'

    auth_token = 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'

    @validator = Restcomm::Util::RequestValidator.new auth_token

    # the callback URL you provided to Restcomm
    url = "http://www.example.com/my/callback/url.xml"

    # the POST variables attached to the request (eg "From", "To")
    post_vars = {}

    # X-Restcomm-Signature header value
    signature = "HpS7PBa1Agvt4OtO+wZp75IuQa0=" # will look something like that

    if @validator.validate(url, post_vars, signature)
      puts "Confirmed to have come from Restcomm."
    else
      puts "NOT VALID.  It might have been spoofed!"
    end

Trailing Slashes
==================

If your URL uses an "index" page, such as index.php or index.html to handle
the request, such as: https://mycompany.com/restcomm where the real page
is served from https://mycompany.com/restcomm/index.php, then Apache or
PHP may rewrite that URL a little bit so it's got a trailing slash, such as
https://mycompany.com/restcomm/ for example.

Using the code above, or similar code in another language, you could
end up with an incorrect hash because Restcomm built the hash using
https://mycompany.com/restcomm and you may have built the hash using
https://mycompany.com/restcomm/. More information can be found in our
documentation on validating requests.

Rack Middleware
===============

If you are serving up your site using a Rack based framework, such as Sinatra or
Rails, you can use the Rack middleware that is included in the gem to protect
from spoofing attempts.

To use the middleware, you need to set it up with your Restcomm Auth Token and a
set of paths to watch. For example, here is how you would use the middleware in
a Sinatra application:

.. code-block:: ruby

    require 'sinatra'
    require 'restcomm-ruby'

    auth_token = 'YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY'

    use Rack::RestcommWebhookAuthentication, auth_token, /\/messages/

    post '/messages' do
      # response with RCML
    end

Now, any POST request to /messages in your application that doesn't validate as
a Restcomm request, will automatically respond with a 403 status code and your
action will not be hit.

If you use subaccounts and need to validate with different auth tokens, you can pass a block to the middleware instead of an auth token. The block will be passed the Account Sid making the call.

.. code-block:: ruby

    use Rack::RestcommWebhookAuthentication, nil, /\/messages/ do |account_sid|
      # lookup auth_token from account_sid
    end

Ensure you pass `nil` for the auth_token when passing a block, otherwise the block will not be called.
