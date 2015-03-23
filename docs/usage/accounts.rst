.. module:: restcomm.rest

===========
Accounts
===========

Managing Restcomm accounts is straightforward.
Update your own account information or create and manage multiple subaccounts.

For more information, see the
`Account REST Resource <http://docs.telestax.com/restcomm-pages/>`_
documentation.


Go to the restcomm-ruby/examples/examples.rb for detailed examples of 
of how to use the restcomm-ruby wrapper


Updating Account Information
----------------------------

Use the :meth:`Account.update` to modify one of your accounts.
Right now the only valid attribute is :attr:`friendly_name`.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @account = @client.accounts.get(account_sid)
    @account.update(friendly_name: "My Awesome Account")


Creating Subaccounts
----------------------

Subaccounts are easy to make.

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host
    @subaccount = @client.accounts.create(name: "My Awesome SubAccount")


Managing Subaccounts
-------------------------

Say you have a subaccount for Client X with an account sid `AC123`

.. code-block:: ruby

    require 'restcomm-ruby'

    # To find these visit http://docs.telestax.com/restcomm-pages/
    account_sid = "ACXXXXXXXXXXXXXXXXX"
    auth_token = "YYYYYYYYYYYYYYYYYY"
    host = "XXX.XXX.XXX.XXX"

    @client = Restcomm::REST::Client.new account_sid, auth_token, host

    # Client X's subaccount
    @subaccount = @client.accounts.get('AC123')

Client X hasn't paid you recently, so let's suspend their account.

.. code-block:: ruby

    @subaccount.update(status: 'suspended')

If it was just a misunderstanding, reenable their account.

.. code-block:: ruby

    @subaccount.update(status: 'active')

Otherwise, close their account permanently.

.. code-block:: ruby

    @subaccount.update(status: 'closed')

.. warning::
    This action can't be undone.

