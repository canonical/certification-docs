Appendix A: Setting up an Eddystone Beacon
==========================================

For the ``bluetooth4/beacon_eddystone_url__{interface}`` test, an eddystone
beacon needs to be set up first. Three methods of setting up a beacon are
described in the following sections, Android Smarthpone Simulartor, Python app
on Linux or Nordic Thingy 52.

Android Smartphone Simulator
----------------------------

There are a number of apps in the Android store that allow a smartphone to
emulate a Bluetooth Eddystone Beacon, such as `Beacon Simulator`_.

.. _Beacon Simulator: https://play.google.com/store/apps/details?id=net.alea.beaconsimulator

Use it to add an “Eddystone URL”, and set URL to: ``http://www.ubuntu.com``,
then enable this simulator. If the SUT can detect this URL the test will pass.

Python app on Linux
-------------------

1. To retrieve the python application use ``git`` to clone the code from this
   github project_.
#. Change ``#!/usr/bin/env python`` to ``#!/usr/bin/env python3`` in
   advertise-url
#. Enable LE advertising and disable BT scanning using the following commands::

     sudo hciconfig hci0 leadv 3
     sudo hciconfig hci0 noscan

#. Make the advertise-url script executable.
#. Start advertising:: 

     sudo ./advertise-url -u http://www.ubuntu.com/

#. Stop advertising:: 

     sudo ./advertise-url -s

.. _project: https://github.com/google/eddystone/tree/master/eddystone-url/implementations/linux 

Nordic Thingy 52
----------------

Prerequisites
^^^^^^^^^^^^^

Hardware
""""""""

This guide uses the Nordic Thingy 52 as an example. It is an IoT sensor kit
that offers Eddystone beacon support. It is the hardware we are using in both
Taipei and Beijing QA labs. There are extra Nordic Thingy 52 devices with the
IoT QAs, please contact us if you need one.

Software
""""""""

To be able to configure the Nordic Thingy 52, the Nordic Thingy mobile App is
required to be able to talk to it. Search for “Nordic Thingy” in your mobil
app store and download it to your phone. The app comes in both iOS and Android
versions. See here for app details and the source code.

Setting Up
^^^^^^^^^^

Powering up the device
""""""""""""""""""""""

Peel off the black plastic case and toggle the on/off switch beside the
microUSB port. The device LED will breathe blue once the device is up and
listening (It'll turn green when connected to another device). More details on
the device in their online start guide.

Configuring the bluetooth beacon
""""""""""""""""""""""""""""""""

1. Have the Nordic Thingy powered up and the Nordic Thingy App installed in
   your phone
#. Launch the app → click the menu icon ≡ at upper left of screen
#. "Add Thingy" → follow instructions and add your device
#. The device LED will turn green once the Thingy is added and connected with
   your phone. The following can also be observed from the app once connection
   between app and Thingy is established:
#. Once the device is setup and connected, click the menu icon ≡ again →
   "Configuration" 
#. Ensure that an Eddystone URL is set. ``https://www.ubuntu.com`` is used in
   the example, but any URL is fine as long as it's a valid Eddystone URL
#. Ensure that Advertising parameters > Advertisement timeout is set to 0 to
   prevent the device from going to sleep
#. Basic setup is now done, you can now exit the app and disconnect your phone
   from the Thingy

Other misc. setup
""""""""""""""""""

1. Make sure the beacon is situated at a place where it is in range with your
   SUT.
#. Make sure the beacon has ongoing power. Suggest to connect to power source
   via the micro USB slot at all times.

Running Checkbox
----------------

Just launch checkbox, make sure the Thingy device is up and in range with your
SUT, and the Eddystone case ``bluetooth4/beacon_eddystone_url__{interface}``
should automatically pass. Note that the Eddystone test case searches for an
Eddystone URL but does not establish an actual connection to the Thingy, so it
is normal for the Thingy LED to remain blue when testing.
