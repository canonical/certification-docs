=============================================================
 MAAS Advanced NUC Installation and Configuration -- Scripted
=============================================================
-----------------------
 (The MANIACS Document)
-----------------------

.. include:: <isonum.txt>

.. header:: |ubuntu_logo|

.. |ubuntu_logo| image:: images/logo-ubuntu_su-white_orange-hex.png
   :scale: 20%

.. footer:: |canonical_logo|

.. |canonical_logo| image:: images/logo-canonical_no-tm-white-hex.png
   :scale: 10%

.. raw:: pdf

   PageBreak oneColumn

.. contents::

.. raw:: pdf

   PageBreak

Purpose
=======

This document describes how to install MAAS on a portable computer (such as
an Intel NUC or laptop) so that you can deploy systems in a test
environment as well as install the certification tools and perform
certification testing. Consult the Ubuntu Certified Hardware Self-Testing
Guide (available from https://certification.canonical.com) for detailed
information on running the certification tests themselves.

Note that this document is based on using the Ubuntu Desktop image for
ease of use, and thus some bits, the Network Manager bits especially,
may not apply if you're using Server without a desktop.

A device (referred to generically as a "portable computer") configured
as described here is not intended for general Internet use. Some
settings relax security in the interest of ease of use, so you should
limit use of the portable computer on the Internet at large.

This document begins with information on the required hardware and then
moves on to details about Ubuntu's network configuration and then the
procedures for installing MAAS. (This document assumes that you know how
to install Ubuntu.) Because the purpose of this document is to help you
bring up a MAAS server for certification purposes, it then describes how
to install additional software and configure MAAS to automatically
install the certification packages on the system under test (SUT).

Figure 1 illustrates the overall configuration that this document will
help you create. This document describes configuration of the Portable
Computer device in the figure. It presupposes the existence of a local
LAN that the portable computer can use for external connections, as well
as the availability of at least one SUT for testing at the end of the
process. (Note that the Internet connection is required for initial
setup, but a properly-configured MAAS server does not need this
connection to bring up SUTs.) Once configured, you will be able to move
the portable computer from one site to another, repopulating the MAAS
LAN at each site.

.. figure:: images/maniac-network.png
   :alt: This document describes configuring a server that manages its own
         subnet and connects to a wider network on another interface.
   :width: 100%

   Figure 1: Network structure in which the portable computer will reside

Hardware Required
=================

Before beginning, you should ensure that you have the following
hardware:

*  Portable computer

   -  Ensure that the portable computer has two network interfaces. A
      laptop with both Ethernet and wi-fi should suffice; or you can use a
      USB network dongle to provide a second interface, particularly for a
      NUC.

   -  Because testing sessions can last for hours, ensure that you have a
      power brick; you should *not* run on battery power!

   -  You can install on a virtual machine in a more general-purpose
      computer, but you'll have to pay careful attention to the network and
      disk settings.

*  System Under Test (SUT) that supports one of the power types MAAS
   supports:

   - American Power Conversion (APC) PDU
   - Cisco UCS Manager 
   - Digital Loggers, Inc. PDU
   - HP Moonshot - iLO Chassis Manager
   - HP Moonshot - iLO (IPMI)
   - IPMI
   - Intel AMT
   - Microsoft OCS - Chassis Manager
   - SeaMicro 15000
   - Sentry Switch CDU
   - VMWare
   - Virsh (virtual systems)

*  Small gigabit switch (8 ports should be enough)

   -  For laptop with Wi-Fi: one Ethernet cable

   -  For NUC or laptop with dongle: two Ethernet cables

   -  For each SUT: one Ethernet cable for each NIC port including the BMC

*  Monitor and keyboard for SUT (helpful, but not strictly required)

*  Monitor, keyboard, and mouse for the MAAS system (a laptop's built-in
   devices should be sufficient)

*  Video cable for NUC (HDMI, Mini DisplayPort, or a converter like a
   MiniDP to VGA)

*  At least 1TB of disk space with which to mirror the Ubuntu archives,
   if desired (an external USB3 hard disk may be used for this, if
   necessary)

Note that these hardware requirements are geared toward a typical
testing environment. You may need to expand this list in some cases. For
instance, if you test multiple servers simultaneously, you may need
additional Ethernet ports.

Installing and Configuring Ubuntu
=================================

Once you've assembled the basic hardware for your portable system, you can
begin preparing it. The initial steps involve installing Ubuntu and setting
up its most basic network settings:

1. Install Ubuntu 14.04 (Trusty Tahr) to the portable system

   -  The Desktop version of Ubuntu is recommended because it enables you
      to easily access the MAAS Dashboard locally without needing a third
      system.

   -  If you choose to use the Server version, you will probably want to
      install the desktop on top of that as it simplifies MAAS access.

   -  This guide assumes the use of Ubuntu 14.04. Although another version
      may work, some details will differ.

#. Boot the portable computer and log in.

#. Configure your *external* network port:

   -  On a laptop, you can use the Wi-Fi (usually ``wlan0``) port as the
      external port.

   -  If you need to use both a built-in Ethernet port and an Ethernet
      dongle, it's best to use the latter as your external port.

   -  In most cases, no explicit configuration of the external port is
      necessary because the Ubuntu Desktop system will have set it up to
      use DHCP, which is appropriate. You can adjust it if necessary,
      though.

   -  In theory, you can configure the external network either via
      ``/etc/network/interfaces`` or by using the Desktop's Network Manager
      tool.

#. Configure your portable computer's *internal* port. This guide assumes
   use of ``eth0`` and a static IP address of 172.16.0.1/22 on this port.

   -  If possible, configure the computer's built-in Ethernet port, rather
      than a plug-in dongle, as the internal port.

   -  You can either edit ``/etc/network/interfaces`` or use the GUI
      Network tool in the System Settings panel to configure the internal
      port. An example ``/etc/network/interfaces`` configuration resembles
      the following::

         auto eth0
         iface eth0 inet static
             address 172.16.0.1
             broadcast 172.16.3.255
             netmask 255.255.252.0

   -  If necessary or desired, you may use a different IP address on the
      *internal* port. If your portable computer will move from one
      *external* network to another, be sure to consider all its likely
      *external* addresses when deciding on its *internal* address and
      netmask.

   -  Do not specify a gateway for the private internal LAN; doing so will
      create confusion when trying to access the Internet via the external
      port.

   -  If you have issues installing packages, check ``route -n`` and make
      sure you don't have a gateway route to the private LAN.

   -  Using a /22 or wider network is advisable for the internal network.
      When so configured, the setup script will use the final two of the
      four resulting octet ranges (for instance, 172.16.2.x and 172.16.3.x
      from 172.16.0.0/22) for DHCP addresses, leaving the first two ranges
      (for instance, 172.16.0.x and 172.16.1.x) for static addresses -- for
      instance, for the MAAS server itself, as well as anything else you
      want to assign a static IP address (perhaps your BMCs).

   -  If you use a /22 or wider network, the MAAS server's address can be
      anything within the first two ranges (for instance, 172.16.0.x or
      172.16.1.x), which are not handled by the computer's own DHCP server.
      If you use a /23 or /24 network, the MAAS server must be within the
      first nine addresses of that range (for instance, 172.16.0.1 through
      172.16.0.9), since the rest of the range is assigned by MAAS's DHCP
      server.

   -  Once you've finished configuring this network port, be sure to
      activate it. If you configured it by editing
      ``/etc/network/interfaces``, type ``sudo ifup eth0`` to activate it.
      (Depending on your starting configuration, you might need to type
      ``sudo ifdown eth0`` or bring it down via your GUI tools before
      bringing it up with its changed configuration.)

#. If you plan to mirror the Ubuntu archives locally, ensure you have
   enough space in the ``/srv`` directory to hold your mirrors. As a
   general rule of thumb, you should set aside about 150GB per release. If
   necessary, mount an extra disk at ``/srv`` to hold your repository
   mirror.

#. Update the software on your system to the latest versions available::

    $ sudo apt-get update
    $ sudo apt-get dist-upgrade

#. Reboot the computer. This enables you to begin using your updated kernel
   (if it was updated) and ensures that your network settings will survive a
   reboot.

.. _`Installing and Configuring MAAS`:

Installing and Configuring MAAS
===============================

Installing MAAS on the computer is quite straightforward; you simply use
APT. With MAAS installed, you can run the ``maniacs-setup`` script to
configure MAAS for use in an Ubuntu certification environment.

Installing MAAS
---------------

Configuring MAAS is described in generic terms at
`http://maas.ubuntu.com/docs/install.html <http://maas.ubuntu.com/docs/install.html>`_.
The more specific procedure for using MAAS in certification testing is:

#. Install the MAAS stable PPA
   (`https://launchpad.net/~maas/+archive/ubuntu/stable <https://launchpad.net/~maas/+archive/ubuntu/stable>`_)::

      $ sudo apt-add-repository ppa:maas/stable

   Currently (July, 2015), Ubuntu 14.04 installs MAAS 1.5 by default. This
   PPA holds version 1.8 of MAAS, which is the recommended version for
   certification testing. (MAAS 1.7 is also acceptable.) Version 1.8 will
   eventually become standard for Ubuntu 14.04, at which point this step
   will become unnecessary.

#. Several scripts and configuration files, some of which are quite
   lengthy, are available in the ``maas-cert-server`` package in the
   hardware certification PPA. You can install the scripts and configuration files
   as follows::

      $ sudo apt-add-repository ppa:hardware-certification/public
      $ sudo apt-get update
      $ sudo apt-get install maas-cert-server

   As of version 0.1.2, the ``maas-cert-server`` package includes a
   dependency on MAAS, so installing ``maas-cert-server`` will also install
   MAAS, as well as all of MAAS's dependencies.

   Most of the ``maas-cert-server`` files will be installed in
   subdirectories of  ``/usr/share/maas-cert-server``, although a few
   appear outside of that directory tree. (Subsequent steps describe how to
   use these files.)

#. Verify that you've installed MAAS 1.8 from the PPA, rather than MAAS
   1.5 or some other version::

      $ dpkg -p maas | grep Version

   If the wrong version is installed, fixing the problem (presumably a
   misconfigured PPA) and upgrading may work. If you upgrade from an
   earlier version of MAAS, be sure to select the option to upgrade all the
   configuration files when the package manager asks about this.

#. Edit the ``/etc/maas-cert-server/config`` file to be sure that the
   variables it contains are correct. Specifically:

   - ``INTERNAL_NET`` must point to your *internal* network device
     (``eth0`` in this document).

   - ``EXTERNAL_NET`` must point to your *external* network device
     (``eth1`` in this documnt, but this might be ``wlan0`` if you're
     using a laptop).

   - Do not adjust other values without consulting with the Server
     Certification Team.

   - Note that there must *not* be spaces surrounding the equal signs
     (``=``) in the assignments!

Running the Setup Script
------------------------

The certification script is called ``maniacs-setup``, and was installed as part
of the ``maas-cert-server`` package. Running this script will set up the MAAS
server with reasonable defaults for certification work; however, the script
will also ask you a few questions along the way::

    $ sudo maniacs-setup
    
    ***************************************************************************
    * Identified networks:
    *   INTERNAL: 172.16.0.1 on eth0
    *   EXTERNAL: 192.168.25.143 on eth1
    *
    * Is this correct (Y/n)?

Be sure your network assignments are correct at this point! If the script
complains about a problem, such as an inability to identify an IP address
or a default route being present on your internal network, go back and
review both your network settings and the contents of your
``/etc/maas-cert-server/config`` file to identify the cause and correct the
problem.

If you approve the settings, the script will display additional messages as
it begins to configure the MAAS server. Some of these messages are the
output of the programs it calls. For the most part this output can be
ignored, but if a problem occurs, be sure to report it in detail, including
the script's output.

Note that at all prompts for a "Y/N" response, the default value is
capitalized; if you press Enter, that default will be used.

The next question acquires a password for the administrative account, which
will have the same name as your default login name::

    ***************************************************************************
    * A MAAS administrative account with a name of ubuntu is being
    * created.
    *
    * Please enter a password for this account:
    * Please re-enter the password for verification:

In most cases, you should enable NAT on your MAAS server; however, if
official policy at the site where the server will be used forbids the use
of NAT, you may opt to leave it disabled::

    ***************************************************************************
    * NAT enables this computer to connect the nodes it controls to the Internet
    * for direct downloads of package updates and to submit certification results
    * to C3.
    *
    * You can configure this computer to automatically start NAT. If you do so, you
    * can disable it temporarily by using the 'flushnat.sh' script or permanently
    * by removing the reference to /usr/sbin/startnat.sh from /etc/rc.local.
    *
    * Do you want to set up this computer to automatically enable NAT (Y/n)?

Note that you can enable NAT on a one-time basis by running the
``startnat.sh`` script and disable it by running the ``flushnat.sh``
script. Both of these scripts come with the ``maas-cert-server`` package.

If your work site has poor Internet connectivity or forbids outgoing
connections, you must create a local mirror of the Ubuntu archives on your
MAAS server. These archives will be stored in the ``/srv`` directory, but
creating them takes a long time because of the amount of data to be
downloaded -- about 150 GB per release. For comparison, HD video consumes
1-8GiB per hour -- usually on the low end of that range for video streaming
services. As should be clear, the result will be significant network demand
that will degrade a typical residential DSL or cable connection for hours,
and possibly exceed your monthly bandwidth allocation::

    ***************************************************************************
    * Mirroring an archive site is necessary if you'll be doing testing while
    * disconnected from the Internet, and is desirable if your test site has
    * poor Internet connectivity. Performing the mirroring operation takes
    * time and disk space, though -- about 150 GiB per release mirrored.
    *
    * Do you want to mirror an archive site for local use (y/N)? Y

If you opt to mirror the archive, the script will ask you to verify the
upstream mirror site::

    * Identified upstream archive is:
    *  http://us.archive.ubuntu.com/ubuntu/
    *
    * Is this correct (Y/n)? y

If you respond ``n`` to this question, the script asks you to specify
another archive site. The script then asks you which Ubuntu releases to
mirror::

    * Do you want to mirror precise (Y/n)? n
    * Do you want to mirror trusty (Y/n)? y
    * Do you want to mirror vivid (Y/n)? n

When it's done, you'll be asked if you want to configure the computer to
automatically update its mirror every day, by modifying the
``/etc/cron.d/apt-mirror`` file. If you do not opt for automatic daily
updates, you can update your mirror at any time by typing ``sudo
apt-mirror``.

::

    * Set up cron to keep your mirror up-to-date (Y/n)? y
    * Cron should update your mirror every morning at 4 AM.
    * You can adjust /etc/cron.d/apt-mirror manually, if you like.

Note that ``maniacs-setup`` configures the system to mirror AMD64, i386,
and source repositories because all three are required by the default APT
configuration. If you want to tweak the mirror configuration, you can do so
by editing the ``/etc/apt/mirror.list`` file -- but do so *after* finishing
with the ``maniacs-setup`` script, and then type ``sudo apt-mirror`` to
pull in any new directories you've specified. You can also configure the
computer to use its own local mirror, if you like::

    * Adjust this computer to use the local mirror (Y/n)? y

The script then gives you the option to retrieve an image used for
virtualization testing. If your site has good Internet connectivity, you
may not need this image; but it's not a bad idea to have it on hand
just in case. Note that the script skips this prompt if it detects an image
already exists in ``/srv``.

::

    ***************************************************************************
    * An Ubuntu cloud image is required for virtualization tests. Having such an
    * image on your MAAS server can be convenient, but downloading it can take
    * a while (it's about 250MiB).
    *
    * Do you want to copy a cloud image for the vitualization tests (Y/n)?

You can customize the site that MAAS tells nodes to use for their
repositories. If you mirrored a repository, the script points nodes to
itself (via its internal IP address); but if you did not mirror a
repository, the script should point your nodes to the same site used by the
MAAS server itself. In either case, you can press the Enter key to accept
the default or enter a new value::

    ***************************************************************************
    * MAAS tells nodes to look to an Ubuntu repository on the Internet. You
    * can customize that site by entering it here, or leave this field blank
    * to use the default value of http://172.16.0.1/ubuntu.
    *
    * Type your repository's URL, or press the Enter key:


At this point, the script tells MAAS to begin importing its boot resources
-- images it uses to enlist, commission, and start nodes. This process can
take several minutes to over an hour to complete. When it's done, the
script also imports the point-release images used for certification;
however, it first asks if you want to import the 12.04 images as well as
the 14.04 images, which it always imports::

    ***************************************************************************
    * Importing point-release images. By default, only 14.04 images will be
    * imported.
    *
    * Do you want to import the 12.04 point-release images, too (y/N)?

Again, this process can take a while, especially if you opt to import the
12.04 images (there are six of them).

Finally, the script announces it's finished its work::

    ***************************************************************************
    * The maniacs-setup script has finished!

In addition to setting the options for which it prompts, ``maniacs-setup``
adjusts some other details of which you should be aware:

- SSH keys are generated for your user account and added to the MAAS
  server. These keys enable you to log in to nodes that MAAS deploys from
  your regular account on the MAAS server.

- Any keys in your ``~/.ssh/authorized_keys`` file on the portable are also
  added to the MAAS setup. Again, this simplifies login.

- The portable computer's SSH server configuration is relaxed so that
  changed host keys do not block outgoing connections. This change is
  *insecure*, but is a practical necessity because your internal network's
  nodes will be redeployed regularly. You should keep this setting in mind
  and minimize your use of this computer to SSH to external sites.

- MAAS is configured to tell nodes to install the Canonical Certification
  Suite whenever they're deployed. This detail increases deployment time
  compared to a generic MAAS installation.

Checking the MAAS Configuration
-------------------------------

At this point, MAAS should be installed and configured; however, it's worth
verifying the most important options in the MAAS Web UI. You may also want
to modify a few settings. To do so, follow these steps:

#. Verify you can access the MAAS Dashboard:

   -  Launch a browser and point it to \http://172.16.0.1/MAAS (your
      internal port).

   -  You should also be able to access this by default on the
      external port, too.

   -  If you provide the computer with a hostname in DNS or ``/etc/hosts``,
      you should be able to access it via that name, as well.

   -  You should see a login prompt.

#. Log in to the Dashboard using your regular username and the password you
   gave to the setup script.

#. Click Images near the top of the MAAS web page. This page will show the Ubuntu images that are available on the server. The setup script imports a 14.04 image for AMD64, as well as custom images for every 14.04 point release. You may need to take additional actions in some cases:

   - If you see a blue circle next to an image, it did not import
     correctly. You can also check the Clusters page to verify the status
     of your image downloads. A successful image import will show Synced
     under Images.

   - If you need to support architectures other than AMD64, you must check
     that architecture and click Apply Changes. This process will probably
     take several minutes to complete.

   - If you need to import i386 point-release images, you must import them
     manually, as described in Appendix B.

#. Click the Clusters link near the top of the web page so you can review
   the DHCP options:

   #.  Click the cluster name for the cluster controller (Cluster Master in
       this example):

       .. image:: images/clusters-page.png
          :width: 98%

   #.  Mouse over the *internal* (normally ``eth0``) network
       interface. (If you don't see your internal interface listed, click
       the "Add Interface" button to add it.) You should see a pair of
       icons appear, one to edit the interface and one to delete it. Click
       the former, then review the following items:

       - Be sure that "Interface" is set to your internal port and that
         "Management" is set to "DHCP and DNS."

       - Review the various IP addresses and netmasks.

       - Click "Save Interface" if you made any changes.

#. Click Settings near the top of the page to load the MAAS Settings page,
   where you review several miscellaneous MAAS details. If you change any
   settings, be sure to click the associated "Save" button within that
   section. Unfortunately, each save button is section-specific and won't
   save changes made in other sections of that page.

Testing the MAAS Server
=======================

At this point, your MAAS server should be set up and configured correctly.
To test it, follow these steps:

#. Prepare a computer by configuring it to boot via PXE. This computer
   need not be a computer you plan to certify; anything that can
   PXE-boot should work, although to fully test the MAAS server, the
   test system should provide IPMI or some other power-control tool that
   MAAS supports.

#. Connect the test computer to the portable computer's *internal* network
   and power it on.

   - The test computer should PXE-boot from the portable MAAS computer.

   - This first boot should be to the enlistment image, which provides
     some very basic information to the MAAS server. Once the node powers
     itself off you should see it listed in the MAAS nodes list
     (\http://localhost/MAAS/#/nodes/ or, on MAAS 1.7,
     \http://localhost/MAAS/nodes/) with a Status field of "New."

   - Note that you will have to refresh the nodes list as it does not
     refresh itself to list new data.

#. Click on the node's hostname to view the node's summary page.

#. If desired, click the node's hostname near the upper-left corner of the
   page. This will enable you to change the hostname to something
   descriptive, such as the computer's model number. Click "Save" when
   you've made your changes.

#. If necessary, click "Edit" in the Machine Summary section to change the
   architecture of the machine. Click "Save Changes" when you're done.

#. If necessary, change the Power Type in the Power section of the page.
   This may necessitate setting an IP address, MAC address, password, or
   other information, depending on the power control technology in use.
   Click "Save Changes" when you're done.

#. Click "Take Action" near the top-right corner of the page, followed by
   "Commission Node" from the resulting drop-down menu. You must then click
   "Go."

   - The node should power on again. This time you'll see it PXE-boot the
     commissioning image. Note that if your test system lacks a BMC or
     other means to remotely control its power, you must manually power it
     on.

   - The node should do a bit more work this time before powering off
     again.

   - Once it's done, the UI will show a Status of "Ready."

#. Once the system powers off after commissioning, click "Take Action"
   followed by "Deploy." You must then click "Go" to confirm this action.

   - The node should power on again (or you will have to control it
     manually if it lacks a BMC). This time it will take longer to finish
     working, as MAAS will install Ubuntu and the certification suite on
     the system.

   - Once it's done, the computer will reboot into its installed image.

   - Log into the node from the MAAS server by using SSH, as in ``ssh
     testnode`` if you've given the node the name ``testnode``.

   - In the node, type ``canonical-certification-server``. The
     certification suite software should run. You can type Ctrl+C to exit;
     at this point, it's sufficient to know that it installed correctly.

If any of these steps fail, you may have run into a MAAS bug; your test
computer may have a buggy PXE, IPMI, or other subsystem; or you may have
misconfigured something in the MAAS setup. You may want to review the
preceding sections to verify that you configured everything correctly.
To help in debugging problems, the node status page includes a section
entitled Latest Node Events with a summary of the last few events
related to the node. (You must refresh the page to see new events.)

.. raw:: pdf

   PageBreak

Appendix A: Updating Fixed Point Release Images
===============================================

From time to time, Canonical updates the LTS versions of Ubuntu with new
point releases, such as 14.04.1, 14.04.2, and so on. Because you must run
the certification tests on the latest point release, updating your MAAS
server with the latest point releases will become necessary, sooner or
later. This task can be accomplished with MAAS 1.7 or 1.8 by installing
custom images.

The ``maniacs-setup`` script automatically downloads and installs all the
available point-release images at the time you first run it. After a new
point release is made, you can update the ``maas-cert-server`` package and
re-run the script with the ``\-\-update-point-releases`` option to have the
script install the new release::

    $ sudo apt-get install maas-cert-server
    $ sudo maniacs-setup --update-point-releases

The script will skip most of the setup steps and download and install only
those point-release images that have not yet been installed. Note that
updating the ``maas-cert-server`` package, or at least the
``maniacs-setup`` script, is a critical part of this process, because the
script has relevant filenames and descriptions hard-coded within it.

If a particular point release is giving you problems, you can delete it
using the MAAS web UI and then update your point-release images as just
described; this will refresh the image to the latest available version.

Note that before you can install a custom image for any given architecture,
you must have first imported at least one image for that architecture via
the conventional means. The ``maniacs-setup`` script detects whether you've
installed the standard i386 images and will install i386 point-release
images if and only if the standard i386 images are already installed.
Currently, only AMD64 and i386 point-release images are available.


.. raw:: pdf

   PageBreak

Appendix B: Adding i386 Support
===============================

By default, the ``maniacs-setup`` script supports only AMD64 (64-bit,
x86-64) nodes. (If you created a local mirror, it includes i386/x86
binaries because they're needed by some 64-bit packages.) If you expect to
run certification tests on i386 (32-bit, x86) computers, though, you must
add support for such systems in MAAS:

#. In the MAAS web UI, click the Images tab.

#. Select "i386" in the "Architecture" column.

#. Click "Apply changes." The standard MAAS i386 images will download. This
   process can take several minutes, and perhaps over an hour on a slow
   Internet connection.

#. Re-run the ``maniacs-setup`` script, but add the
   ``\-\-update-point-releases`` option to the script, as described in
   Appendix A. This will cause the script to download and add the
   point-release images for i386 systems.

That's it. You can add support for ppc64el, ARM64, or other architectures
in a similar way; however, there are currently no point-release images for
these architectures. Please consult the Server Certification Team if you
need to certify systems using these CPUs.

.. raw:: pdf

   PageBreak

Appendix C: Performing a Partial Restore
========================================

If the MAAS server's support files (the PXE boot images and related
files) become damaged, PXE-booting SUTs may fail. The SUT may fail to
retrieve PXE boot images or the boot may fail with any number of
symptoms later in the process. If you're unable to discover a cause and
solution through less drastic means, one possible recovery procedure is
to restore those files to a fresh state; however, be aware that this
procedure will *destroy all existing node definitions.* Thus (and because
the solution involves downloading new boot images, which can be
time-consuming), you should attempt this solution only as a last resort.
Steps 1 and 6-7 of the following procedure are the minimum required;
steps 2-5 make for a more thorough cleansing of the system. The overall
procedure is:

#. Click the Clusters link in the MAAS server's web interface (to reach
   the server's ``/MAAS/clusters/`` page).

#. Click the small trash can icon that appear near the right side of the
   page associated with your malfunctioning cluster when you mouse over it,
   and then confirm the operation. This will delete the cluster
   controller's definition.

#. Delete the contents, including all subdirectories, of the
   ``/var/lib/maas/boot-resources`` directory on the portable server.

#. In a shell, reconfigure the ``maas-cluster-controller`` and
   ``maas-region-controller`` packages::

      $ sudo dpkg-reconfigure maas-cluster-controller
      $ sudo dpkg-reconfigure maas-region-controller

   You should not need to adjust the default values.

5. Reset the cluster controller's DHCP and DNS options.

6. If necessary or desired, adjust the images you want to import.

7. Re-run the ``maniacs-setup`` script with the
   ``\-\-update-point-releases`` option, as described in Appendix A, to
   refresh your point-release images.

This procedure should restore your ability to PXE-boot your SUTs.

.. raw:: pdf

   PageBreak

Appendix D: Glossary
====================

The following definitions apply to terms used in this document.

1Gbps
  1 Gigabit - Network speed for Gigabit Ethernet (1000Mbps).

10Gbps
  10 Gigabit - Network speed for 10 Gigabit Ethernet (10,000Mbps).

BMC
  Baseboard Management Controller -- A device in many server models
  that allows remote in- and out-of-band management of hardware.

DHCP
  Dynamic Host Control Protocol -- method for providing IP addresses
  to the SUTs.

IPMI
  Intelligent Platform Management Interface -- A technology for
  remotely connecting to a system to perform management functions.

LAN
  Local Area Network -- the network to which your SUTs are connected. The
  LAN does not need to be Internet accessible (though that is preferable if
  possible).

MAAS
  Metal as a Service -- a Canonical product for provisioning systems
  quickly and easily.

NIC
  Network Interface Card -- the network device(s).

NUC
  A small form-factor PC product from Intel.

PXE
  Pre-boot Execution Environment -- A technology that allows you to
  boot a system using remote images for easy deployment or network-based
  installation.

SUT
  System Under Test -- The machine you are testing for certification.
