.. module:: restcomm.rest.resources

================
Recordings
================

For more information, see the
`Recordings REST Resource <http://docs.telestax.com/restcomm-pages/>`_
documentation.


Audio Formats
-----------------

Each :class:`Recording` has a few special methods. To get the url
for the wav format of this recording, use :meth:`Recording.wav`. For the
mp3 format, use :meth:`Recording.mp3`. To make requests for either of
these formats use the same method with a '!' appended. These methods
both take a block to be executed as soon as the response returns.


Listing Your Recordings
----------------------------

The following code will print out the :attr:`duration`
for each :class:`Recording`.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host

    @client.recordings.list().each do |recording|
      puts recording.duration
    end

You can filter recordings by CallSid by passing the Sid as :attr:`call`.
Filter recordings using :attr:`DateCreated<` and :attr:`DateCreated>` dates.

The following will only show recordings made before January 1, 2011.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @client.recordings.list('DateCreated<' => '2011-01-01').each do |recording|
      puts recording.duration
    end

Deleting Recordings
---------------------

The :class:`Recordings` resource allows you to delete unnecessary recordings.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @client.recordings.get("RC123").delete()


Accessing Related Transcptions
-------------------------------

The :class:`Recordings` allows you to retrieve associated transcriptions.
The following prints out the text for each of the transcriptions associated
with this recording.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @recording = @client.recordings.get("RC123")

    @recording.transcriptions.list().each do |transcription|
      puts transcription.transcription_text
    end

