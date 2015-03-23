.. module:: restcomm.rest.resources

================
Transcriptions
================

Transcriptions are generated from recordings via the
`RCML <Record> verb <http://www.restcomm.com/docs/api/twiml/record>`_.
Using the API, you can only read your transcription records.

For more information, see the `Transcriptions REST Resource
<http://docs.telestax.com/restcomm-pages/>`_ documentation.


Listing Your Transcriptions
----------------------------

The following code will print out the length of each :class:`Transcription`.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"


    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @client.transcriptions.list().each do |transcription|
      puts transcription.duration
    end

