.. _usage-twiml:

.. module:: restcomm.twiml

==============
RCML Creation
==============

RCML creation begins with the :class:`Response` verb.
Each successive verb is created by calling various methods on the response,
such as :meth:`say` or :meth:`play`.
These methods return the verbs they create to ease creation of nested RCML.
To finish, call the :meth:`toxml` method on the :class:`Response`,
which returns raw RCML.

.. code-block:: ruby

    require 'restcomm-ruby'

    Restcomm::RCML::Response.new do |r|
      r.Say "Hello"
    end.text

.. code-block:: xml

   <?xml version="1.0" encoding="utf-8"?>
   <Response><Say>Hello</Say><Response>

The verb methods (outlined in the :doc:`complete reference </api/twiml>`)
take the body (only text) of the verb as the first argument.
All attributes are keyword arguments.

.. code-block:: ruby

    require 'restcomm-ruby'

    Restcomm::RCML::Response.new do |r|
      r.Play "https://api.restcomm.com/cowbell.mp3", loop: 5
    end.text

.. code-block:: xml

    <?xml version="1.0" encoding="utf-8"?>
    <Response>
      <Play loop="3">https://api.restcomm.com/cowbell.mp3</Play>
    <Response>

Any example of nesting nouns in verbs

.. code-block:: ruby

    require 'restcomm-ruby'

    Restcomm::RCML::Response.new do |r|
      r.Say "hello"
      r.Gather finishOnKey: => 4 do |g|
        g.Say "world"
      end
    end.text

which returns the following

.. code-block:: xml

    <?xml version="1.0" encoding="utf-8"?>
    <Response>
      <Say>Hello</Say>
      <Gather finishOnKey="4"><Say>World</Say></Gather>
    </Response>
