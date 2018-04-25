===========================================================
 Ubuntu Server Hardware Certification Coverage (18.04 LTS)
===========================================================

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

.. role:: green-text

The Ubuntu Certification team is continuously revisiting the scope of the
tests comprising the Ubuntu Certified programme and it is reviewed every
six months, following the same cadence as the Ubuntu OS. This revision of
new tests is performed during Ubuntu's development cycle and it never
applies to already-released versions of Ubuntu.

This document lists the coverage for certification of Ubuntu Server 18.04
LTS. This coverage will remain as it is for Ubuntu Server 18.04 LTS through
its life cycle.

The following test categories are specified: 

Whitelist
  Features that are required for certification. If any of the tests in the
  whitelist fails, the  certification will fail.

Greylist
  Features that are tested, but that don't block certification. If any of
  the tests under the greylist fail, a note will be added to the
  certificate to warn the potential customer or user.

Blacklist
  Features that are not currently tested. The items in the blacklist
  category are just reference items: **anything not explicitly called out in
  the whitelist or greylist categories can be considered part of the
  blacklist category.**  Canonical has the option to add and remove tests,
  provided they are preapproved between Canonical and the customer.

For Blacklist items, Canonical **may** introduce tests for those items at
any point; however, those tests will be introduced as Greylist items until
the next major suite revision.  For example:

MAAS compatibility testing was not required for 12.04 LTS.  As of 12.04.3,
MAAS was tested as a Greylist item during certification. Thus, if a
greylist item does not work, the certification is not blocked but the
testing is performed and that data is recorded.  As of 14.04, MAAS
compatibility was required to pass certification, and thus the MAAS test
moved from Greylist to Whitelist.  Prior releases of Ubuntu Server LTS test
relied on outside setup of PXE, FTP, TFTP, and Power (IPMI) testing.  With
Ubuntu Server 14.04 LTS testing all of that functionality is now provided
via the testing tools and framework to ease setup,  reduce variability
between lab infrastructure, and align with scale out deployment processes.

Note: only categories of hardware are tested and not specific types of
hardware. For example, tests are run to verify USB controllers work, but
the type of peripheral(s) used during those tests are not specified.

Full test case descriptions can be found at the Canonical Certification
portal for partners:

     http://certification.canonical.com
 
18.04 LTS Coverage Changes
==========================

New for 18.04 LTS is the introduction of Comprehensive Server Certification.
This change in policy means that all Vendor Approved Options for sale with a
given model Server must be tested before the Server can be considered
Certified.

Once an Option has been tested in one Model, it does not need to be retested
for another Model.  This increases the scope of testing but minimizes the amout
of extra test work necessary.  Thus, if Model A and Model B both feature
Networkcard 1, Networkcard 1 must only be tested once in either Model A or
Model B, and will be considered tested for both.

Additional changes to Server Certification Test Coverage are highlighted
below.

Whitelist
---------

* Processors:

  * ia32 (x86) and x86_64 processors are tested to ensure proper
    functionality.

    * By default, 64-bit Ubuntu is used. 32-bit Ubuntu is used only on
      processors that are 32-bit. 32-bit Ubuntu is *not* tested on 64-bit
      processors.

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time. This utilizes the test tool
    "stress-ng" available in the Universe repositories.

* Memory:

  * Proper detection

  * General usage 

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time. This utilizes the test tool
    "stress-ng" available in the Universe repository.

* Internal hard drives (RAID AND Non-RAID) [1]_:

  .. [1] Only RAID hardware solutions.

  * Performance

  * Storage devices (HDDs, RAID LUNs) are I/O load tested using Open
    Source tools

  * Basic RAID levels (0,1 or 5)

* Mezzanine or Daughter Cards

  * Any mezzanine or daughter card that enables ports on the motherboard must
    pass. (e.g. a mezz card that enables 10Gb on onboard SFP+ ports)

* Optical drives (CD/DVD):

  * Read

* Networking:

  * Ethernet devices are tested at their full speed and must show a minimum of
    80% of advertised maximum speed.

  * Testing is conducted for 1 hour per port.

* System management [2]_ [3]_:

  .. [2] Applicable to systems that ship with a BMC or similar management
         device.
  
  .. [3] Limited to Power Management and User/Password management for MAAS
         control.

  * In-Band Management (IPMI)

  * Out-of-Band Management (IPMI, AMT, etc)

  * Chassis Management (Blade / Cartridge type systems)

  * Virtual Machine Management (for LPAR or VM systems like Power or z13)

  * MAAS Compatibility

* USB controllers. USB ports are tested to ensure operability.

  * USB 2.0/3.x

* Boot/Reboot

  * Includes PXE Booting

* Virtualization [4]_:

  .. [4] Only applies to Bare Metal and Ubuntu as Guest on a KVM Hypervisor.

  * Virtualization extensions

  * Running an Ubuntu image on KVM

Greylist
--------

* System Identification

  * Ensure that the Make/Model being returned to the operating system and
    via OOB Management is the same as what is being submitted for
    certification.

* Firmware Updates

  * Firmware update tools packaged for Ubuntu

  * Firmware updates possible from within the Ubuntu OS

* Storage Management Tools

  * Storage management tools packaged and documented for Ubuntu

  * Storage management tools should be fully functional on Ubuntu
    (executable from Ubuntu)

* Advanced RAID levels (10, 15, 50, etc)

* Infiniband

* External Storage

  * iSCSI

  * FC, FCoE

* Input devices:

  * External keyboard (basic functionality)

Blacklist
---------

* External PCI cards

* Graphics

* Tape devices

* Advanced network configuration

* E-Star requirements

Q & A
=====

What do you mean by MAAS Compatibility?
  As of 14.04 LTS, any system that is listed as Certified has been tested
  with Ubuntu's deployment tools. This means the system can be deployed
  using Metal as a Service (MAAS) and workloads can be installed to it.  This
  is determined by using MAAS to provision and deploy the OS onto the target
  systems to be tested. Additionally, there should be as little human
  intervention as necessary to perform this task, such as the user manually
  needing to power the machine on and off between during the provision
  process.

Does changing the speed of processors require a new certificate?
  No. Only changing the CPU family would require retesting and issuing a
  new certificate.

What about non-x86 processors?
  Any architecture supported by Ubuntu may be certified.  At this time, this
  includes ia32, x86_64, ARM, ARM64, PPC64LE and s390x.


Complete Test Plan
==================

The Hardware Certification Testing Coverage aims to test as thoroughly as
possible and ensure that systems and their components are compatible and
function well with Ubuntu and Ubuntu Tools; however, it is not possible for
this scope of testing to catch issues that are unique to a system or
platform or  may appear during the hardware development lifecycle.  For
example, tools to manage firmware, storage configurations, etc., and their
usage vary by vendor and platform, but end users expect this functionality.
This testing is not done by the Ubuntu Server testing tools and and should
be tested by the Partner on a regular basis.

Because of this, please work with your Technical Partner Manager to outline
and document those tests that are not covered by the standard tooling. 
Partners are strongly encouraged to integrate the Ubuntu test tools and
Ubuntu OS into their own processes for OS and Hardware Validation.  Your
Technical Partner Manager will gladly help assist you in any way to make
this possible.
