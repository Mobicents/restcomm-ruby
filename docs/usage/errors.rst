Error Handling
==============

Exceptions
----------
If the Restcomm API returns a 400 or a 500 level HTTP response,
the restcomm-ruby library will throw a :class:`Restcomm::REST::RequestError`.
400-level errors are normal during API operation ("Invalid number",
"Cannot deliver SMS to that number", for example) and should be
handled appropriately.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"
	

    begin
      @client = Restcomm::REST::Client.new account_sid, auth_token, host
      client.messages.create({
        from: '+1234567890',
        to: '+1234567890',
        body: 'Hello world'
      })
    rescue Restcomm::REST::RequestError => e
      puts e.message
    end
