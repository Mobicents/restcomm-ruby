=============================
Restcomm Ruby Helper Library
=============================

.. _installation:

Installation
================

Just install the gem!

.. code-block:: bash

    $ gem install restcomm-ruby

Getting Started
================

The :doc:`/getting-started` will get you up and running in a few quick minutes.
This guide assumes you understand the core concepts of Restcomm.
If you've never used Restcomm before, don't fret! Just read
`about how Restcomm works <http://www.restcomm.com/api/>`_ and then jump in!


.. _user-guide:

User Guide
==================

Functionality is split over three different sub-packages within
**restcomm-ruby**. Below are in-depth guides to specific portions of the
library.


REST API
----------

Query the Restcomm REST API to create phone calls, send SMS/MMS messages and more!

.. toctree::
    :maxdepth: 1

    usage/basics
    usage/errors
    usage/messages
    usage/phone-calls
    usage/phone-numbers
    usage/accounts
    usage/conferences
    usage/applications
    usage/notifications
    usage/recordings
    usage/transcriptions
    usage/caller-ids
    usage/queues
    usage/sip

RCML
---------

Generates valid RCML for controlling and manipulating phone calls.

.. toctree::
    :maxdepth: 2

    usage/twiml

Utilities
----------

Small functions useful for validating requests are coming from Restcomm

.. toctree::
    :maxdepth: 1

    usage/validation
    usage/token-generation

Frequently Asked Questions
==========================

What to do if you get an ``ImportError``, and some advice about how to format
phone numbers.

.. toctree::
    :maxdepth: 2

    faq

Changelog
=========

See the :doc:`/changelog` for version history.

Support and Development
==========================
All development occurs over on
`Github <https://github.com/restcomm/restcomm-ruby>`_. To checkout the source,

.. code-block:: bash

    $ git clone git@github.com:restcomm/restcomm-ruby.git


Report bugs using the Github
`issue tracker <https://github.com/restcomm/restcomm-ruby/issues>`_.

If you have questions that aren't answered by this documentation,
ask the `#restcomm IRC channel <irc://irc.freenode.net/#restcomm>`_
