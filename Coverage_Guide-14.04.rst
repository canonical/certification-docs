===========================================================
 Ubuntu Server Hardware Certification Coverage (14.04 LTS)
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
six months, following the same Ubuntu cadence. This revision of new tests
is performed during Ubuntu's development cycle and it never applies to
already released versions of Ubuntu.

This document lists the coverage for certification of Ubuntu Server 14.04
LTS. This coverage will remain as it is for Ubuntu Server 14.04 LTS through
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
  blacklist category.**  Canonical has the option to add and remove tests
  provided they are preapproved between Canonical and the customer.

For Blacklist items, Canonical MAY introduce tests for those items at any
point, however, those tests will be introduced as Greylist items until the
next major suite revision.  For example:

MAAS compatibility testing was not required for 12.04 LTS.  As of 12.04.3,
MAAS was tested as a Greylist items during certification. Thus, if they do
not work, the cert is not blocked but the testing is performed and that
data is recorded.  As of 14.04, MAAS compatibility will be required to pass
certification, and thus they will move from Greylist to Whitelist.  Prior
releases of Ubuntu Server LTS test relied on outside setup of PXE, FTP,
TFTP, and Power (IPMI) testing.  With Ubuntu Server 14.04 LTS testing all
of that functionality is new provided via the testing tools and framework
to ease setup,  reduce variability between lab infrastructure, and align
with scale out deployment processes.

Note: only categories of hardware are tested and not specific types of
hardware. For example, tests are run to verify USB controllers work, but
the type of peripheral(s) used during those tests are not specified.

Full test case descriptions can be found at the Canonical Certification
portal for partners:

     http://certification.canonical.com
 
14.04 LTS Coverage Changes
==========================

New for Ubuntu 14.04 LTS are some changes in how certification is performed
and the items being tested.  Among these changes is the new requirement
that any certified system must be compatible with Ubuntu deployment tools. 
This testing will now require a server on the testbed to provide the MAAS
services.  The server will be used to deploy the system to be tested and
then deploy a workload onto that test system which will perform the Ubuntu
Server Certification Tests.  As new point releases are released multiple
workloads may be deployed to test for regressions and system upgradability.

Additional changes to Server Certification Test Coverage are highlighted
below.

Whitelist
---------

* Processors:

  * ia32 (x86) and  x86_64 processors are tested to ensure proper
    functionality.

    * By default, 64Bit Ubuntu is used. 32Bit Ubuntu is used on
      processors that are 32bit only.

  * A general stress test is performed for to verify that the system can
    handle a sustained high load for a period of time. This utilizes the test
    tool "stress" available in the Universe repositories.

* Memory:

  * Proper detection

  * General usage 

  * A general stress test is performed to verify that the system can
    handle a sustained high load for a period of time. This utilizes the
    test tool "stress" available in the Universe repository.

* Internal hard drives (RAID AND Non-RAID) [1]_:

  .. [1] Only RAID hardware solutions.

  * Performance

  * Storage devices (HDDs, RAID LUNs) are I/O Load tested using Open
    Source tools

  * :green-text:`Basic RAID levels (0,1 or 5)`

* Optical drives (CD/DVD):

  * Read

* Networking:

  * 1Gb and 10Gb Ethernet

* System management [2]_:

  .. [2] Applicable to systems that ship with a BMC or similar management
         device.

  * In-Band Management (DCMI, IPMI, etc)

  * :green-text:`Out-of-Band Management (DCMI, IPMI, etc)`

  * :green-text:`MAAS Compatibility`

* USB controllers. USB ports are tested to ensure operability.

  * USB 2.0/:green-text:`3.0`

* Input devices:

  * External keyboard (basic functionality)

* Boot/Reboot

  * :green-text:`Includes PXE Booting`

* Virtualization extensions

Greylist
--------

* :green-text:`System Identification`

  * Ensure that the Make/Model being returned to the operating system and
    via OOB Management is the same as what is being submitted for
    certification.

* :green-text:`Firmware Updates`

  * Firmware update tools packaged for Ubuntu

  * Firmware updates possible from within the Ubuntu OS

* :green-text:`Storage Management Tools`

  * Storage management tools packaged and documented for Ubuntu

  * Storage management tools should be fully functional on Ubuntu
    (executable from Ubuntu)

* Running an Ubuntu image on KVM

* :green-text:`Advanced RAID levels (10, 15, 50, etc)`

* :green-text:`Infiniband`

* :green-text:`External Storage`

  * iSCSI

  * FC, FCoE

* Non-x86 architectures may be tested as part of this or other programmes

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
  As of 14.04 LTS, any system that is listed as Certificatied has been tested
  with Ubuntu's deployment tools.  This means the system can be deployed
  using Metal as a Service (MAAS) and workloads can be installed to it.  This
  is determined by using MAAS to provision and deploy the OS onto the target
  systems to be tested.  Additionally, there should be as little human
  intervention as necessary to perform this task such as the user manually
  needing to power the machine on and off between during the provision
  process.

Does changing the speed of processors require a new certificate?
  No. Only changing the CPU family would require retesting and issuing a
  new certificate.

What about non-x86 processors?
  At this time only x86 based systems fall under the standard Ubuntu Server
  Certification Guides.  If you have questions about testing, certifying, or
  supporting other architectures please work with your Canonical account
  team.


Complete Test Plan
==================

The Hardware Certification Testing Coverage aims to test as thoroughly as
possible and ensure that systems and their components are compatible and
function well with Ubuntu and Ubuntu Tools.  However, it is not possible
for this scope of testing to catch issues that are unique to a system or
platform or  may appear during the hardware development lifecycle.  For
example, tools to manage firmware, storage configurations, etc.,  and their
usage vary by vendors and platforms but is expected functionality of end
users.  This testing is not done by the Ubuntu Server testing tools and and
should be tested by the Partner on a regular basis.

Because of this, please work with your Technical Partner Manager to outline
and document those tests that are not covered by the standard tooling. 
Partners are strongly encouraged to integrate the Ubuntu test tools and
Ubuntu OS into their own processes for OS and Hardware Validation.  Your
Technical Partner Manager will gladly help assist you in any way to make
this possible.
