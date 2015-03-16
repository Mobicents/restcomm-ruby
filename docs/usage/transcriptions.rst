.. module:: restcomm.rest.resources

================
Transcriptions
================

Transcriptions are generated from recordings via the
`RCML <Record> verb <http://www.restcomm.com/docs/api/twiml/record>`_.
Using the API, you can only read your transcription records.

For more information, see the `Transcriptions REST Resource
<http://www.restcomm.com/docs/api/rest/transcription>`_ documentation.


Listing Your Transcriptions
----------------------------

The following code will print out the length of each :class:`Transcription`.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token
    @client.transcriptions.list().each do |transcription|
      puts transcription.duration
    end

