.. module:: restcomm.rest.resources

=================
Applications
=================

An application inside of Restcomm is just a set of URLs and other configuration
data that tells Restcomm how to behave when one of your Restcomm numbers receives
a call or message.

For more information, see the `Application REST Resource
<http://www.restcomm.com/docs/api/rest/applications>`_ documentation.


Listing Your Applications
--------------------------

The following code will print out the :attr:`friendly_name` for each :class:`Application`.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token
    @client.applications.each do |app|
      puts app.friendly_name
    end


Filtering Applications
---------------------------

You can filter applications by FriendlyName

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token
    @client.applications.list(friendly_name: 'FOO').each do |app|
      puts app.sid
    end


Creating an Application
-------------------------

When creating an application, no fields are required. We create an application
with only a :attr:`friendly_name`. The :meth:`Applications.create()` method
accepts many other arguments for url configuration.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token
    @application = @client.applications.create(
      friendly_name: "My New App"
    )

Updating an Application
------------------------

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token

    url = "http://twimlets.com/holdmusic?Bucket=com.restcomm.music.ambient"
    app_sid = 'AP123' # the app you'd like to update

    @application = @client.applications.get(app_sid)
    @application.update(voice_url: url)

Deleting an Application
-------------------------

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit https://www.restcomm.com/user/account
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"

    @client = Restcomm::REST::Client.new account_sid, auth_token

    app_sid = 'AP123' # the app you'd like to delete
    @client.applications.get(app_sid)
    @application.delete()

