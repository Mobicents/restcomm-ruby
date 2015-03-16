===========
Quickstart
===========

Getting started with the Restcomm API couldn't be easier. Create a Restcomm REST
client to get started. For example, the following code makes a call using the
Restcomm REST API.


Make a Call
===============

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token
    @call = @client.calls.create(
      to: "9991231234",
      from: "9991231234",
      url: "http://twimlets.com/holdmusic?Bucket=com.restcomm.music.ambient"
    )
    puts @call.length
    puts @call.sid


Send an SMS
===========

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token

    @message = @client.messages.create(
      to: "+12316851234",
      from: "+15555555555",
      body: "Hello there!"
    )

Send an MMS
===========

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token

    @message = @client.messages.create(
      to: "+15558676309",
      from: "+15555555555",
      body: "Jenny I need you!",
      media_url: "http://restcomm.com/heart.jpg"
    )

Generating RCML
=================

To control phone calls, your application needs to output `RCML
<http://www.restcomm.com/docs/api/twiml/>`_. Use :class:`restcomm.twiml.Response`
to easily create such responses.

.. code-block:: ruby

    Restcomm::RCML::Response do |r|
        r.Play "https://api.restcomm.com/cowbell.mp3", loop: 5
    end.text

.. code-block:: xml

    <?xml version="1.0" encoding="utf-8"?>
    <Response>
        <Play loop="5">https://api.restcomm.com/cowbell.mp3</Play>
    <Response>


Digging Deeper
========================

The full power of the Restcomm API is at your fingertips. The :ref:`user-guide`
explains all the awesome features available to use.

