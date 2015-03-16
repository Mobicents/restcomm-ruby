.. module:: restcomm.util

===========================
Generate Capability Tokens
===========================

`Restcomm Client <http://www.restcomm.com/api/client>`_ allows you to make and
receive connections in the browser.
You can place a call to a phone on the PSTN network,
all without leaving your browser. See the `Restcomm Client Quickstart
<http:/www.restcomm.com/docs/quickstart/client>`_ to get up and running with
Restcomm Client.

Capability tokens are used by `Restcomm Client
<http://www.restcomm.com/api/client>`_ to provide connection
security and authorization. The `Capability Token documentation
<https://www.restcomm.com/docs/client/capability-tokens>`_ explains in depth the purpose and
features of these tokens.

:class:`Restcomm::Util::Capability` is responsible for the creation of these
capability tokens. You'll need your Restcomm AccountSid and AuthToken.

.. code-block:: ruby

    require 'restcomm-ruby'

    # Find these values at restcomm.com/user/account
    account_sid = "AC123123"
    auth_token = "secret"

    @capability = Restcomm::Util::Capability.new account_sid, auth_token

You can also configure capability tokens using the top level configure method,
like so:

.. code-block:: ruby

    require 'restcomm-ruby'

    Restcomm.configure do |config|
      config.account_sid = "ACXXXXXXXXXXXXXXXXX"
      config.auth_token = "YYYYYYYYYYYYYYYYYY"
    end

    @capability = Restcomm::Util::Capability.new



Allow Incoming Connections
==============================

Before a device running `Restcomm Client <http://www.restcomm.com/api/client>`_
can recieve incoming connections, the instance must first register a name
(such as "Alice" or "Bob").
The :meth:`allow_client_incoming` method adds the client name to the
capability token.

.. code-block:: ruby

    @capability.allow_client_incoming("Alice")


Allow Outgoing Connections
==============================

To make an outgoing connection from a
`Restcomm Client <http://www.restcomm.com/api/client>`_ device,
you'll need to choose a
`Restcomm Application <http://www.restcomm.com/docs/api/rest/applications>`_
to handle RCML URLs. A Restcomm Application is a collection of URLs responsible
for outputting valid RCML to control phone calls and messages.

.. code-block:: ruby

    # Restcomm Application Sid
    application_sid = "APabe7650f654fc34655fc81ae71caa3ff"
    @capability.allow_client_outgoing(application_sid)


Generate a Token
==================

.. code-block:: ruby

    @token = @capability.generate()

By default, this token will expire in one hour. If you'd like to change the
token expiration, :meth:`generate` takes an optional :attr:`ttl` argument.

.. code-block:: ruby

    @token = @capability.generate(ttl=600)

This token will now expire in 10 minutes. If you haven't guessed already,
:attr:`ttl` is expressed in seconds.

