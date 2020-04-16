===========================================================
 Ubuntu Server Hardware Certification Coverage (20.04 LTS)
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

This document lists the coverage for certification of Ubuntu Server 20.04
LTS. This coverage will remain as it is for Ubuntu Server 20.04 LTS through
its life cycle.

The following test categories are specified: 

Blocking
  Features that are required for certification. If any of the blocking tests
  fail, the certification will fail.

Non-Blocking
  Features that are tested, but that don't block certification. If any of
  the non-blocking tests fail, a note will be added to the certificate where
  apropriate to warn the potential customer or user.

Untested
  Features that are not currently tested. The items in the Untested
  category are just reference items: **anything not explicitly called out in
  the Blocking or Non-Blocking categories can be considered part of the
  Untested category.**  Canonical has the option to add and remove tests,
  provided they are preapproved between Canonical and the customer.

For Untested items, Canonical **may** introduce tests for those items at
any point; however, those tests will be introduced as Non-Blocking items until
the next major suite revision.  For example:

In previous versions of Ubuntu up to 16.04 LTS, we did not test GPGPUs.  Thus
GPGPUs were Untested items.  As of 18.04 LTS, GPGPU testing was introduced as a
tech preview test, which is non-blocking.  As of 20.04 LTS, AI/ML focused systems
MUST pass GPGPU testing (GPGPUs are a blocker here) but standard servers that
happen to also have GPGPU options are not gated if GPGPUs are not tested.

The use of Canonical's `Metal as a Service`_ tool is a required part of server
certification testing. Thus MAAS is considered a blocker. If a system cannot be
automatically enlisted, commissioned, and deployed using MAAS **without user
interaction other than manually powering the system on the first time** the
system cannot pass Ubuntu Server Certification.  

.. _`Metal as a Service`:
   https://maas.io

Note: only categories of hardware are tested and not specific types of
hardware. For example, tests are run to verify that USB controllers work,
but the type of peripheral(s) used during those tests are not specified.

Full test case descriptions can be found at the Canonical Certification
portal for partners:

     http://certification.canonical.com
 
20.04 LTS Coverage Changes
==========================

As introduced in the 18.04 LTS cycel, Ubuntu 20.04 LTS continues the policy of
Comprehensive Server Certification. This means that all Vendor Approved Options
for sale with a given model Server must be tested at some point.

Once a Vendor Approved Option has been tested in one Server Model, it does not
need to be retested for another Server Model.  This increases the scope of
testing but minimizes the amount of extra test work necessary.  Thus, if Model A
and Model B both feature Networkcard 1, Networkcard 1 must only be tested once in
either Model A or Model B, and will be considered tested for both.

Additional changes to Server Certification Test Coverage are highlighted
below.

Blocking
--------

* Processors:

  * All supported processor architectures are tested to ensure proper
    functionality.

    * By default, 64-bit Ubuntu is used. 32-bit Ubuntu is used only on
      processors that are 32-bit. 32-bit Ubuntu is *not* tested on 64-bit
      processors.

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time. This utilizes the test tool
    "stress-ng" available in the Universe repositories.

  * Currently, the following processor architectures are supported and must pass
    Certification testing

    * Both Intel and AMD CPUs (AMD64 only)

    * IBM and OpenPOWER Power 8 and Power 9 (ppc64el)

    * ARM64 (ARM64 based Server Models must use a SoC that has been `SoC
      Certified`_.
      
    * IBM s390x

    .. _`SoC Certified`:
       https://certification.ubuntu.com/soc

* Memory:

  * Proper detection

  * General usage 

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time. This utilizes the test tool
    "stress-ng" available in the Universe repository.

* Intel Optane DCPMM devices:

  * Configuration

  * Intel DCPMMs are tested in both Memory and AppDirect [1]_ (Storage) modes.

    .. [1] fsdax, raw, and sector modes only, devdax is not currently tested.

* Internal storage (RAID AND Non-RAID) [2]_:

  .. [2] Only RAID hardware solutions.

  * Performance

  * Storage devices (HDDs, SSDs, Hybrid, NVMe, RAID LUNs) are I/O load tested
    using Open Source tools

  * Basic RAID levels (0,1 or 5)

* Mezzanine or Daughter Cards

  * Any mezzanine or daughter card that enables ports on the motherboard must
    pass. (e.g. a mezz card that enables 10Gb on onboard SFP+ ports)

* Optical drives (CD/DVD):

  * Read

* Networking:

  * Ethernet devices are tested at their full speed and must show a minimum of
    80% of advertised maximum speed.

  * High Speed network devices (40 Gb/s and faster must also meet this
    requirement, however additional configuration and testing steps may be
    required)

  * Testing is conducted for 1 hour per port.

* System management [3]_ [4]_:

  .. [3] Applicable to systems that ship with a BMC or similar management
         device.
  
  .. [4] Limited to Power Management and User/Password management for MAAS
         control and probing for info from the BMC.

  * In-Band Management (IPMI)

  * Out-of-Band Management (IPMI, AMT, etc)

  * Chassis Management (Blade / Cartridge type systems)

  * Virtual Machine Management (for LPAR or VM systems like Power or z13)

  * MAAS Compatibility

* USB controllers. USB ports are tested to ensure operability.

  * USB 2.0/3.x

* Boot/Reboot

  * PXE Booting from a MAAS server

  * Rebooting to finalize deployment

* Virtualization [5]_:

  .. [5] Only applies to Ubuntu on Bare Metal and limited LPAR scenarios.

  * Virtualization extensions

  * Running an Ubuntu image on KVM

* Containers

  * LXC must function

* System Identification

  * Ensure that the Make/Model being returned to the operating system and
    via OOB Management is the same as what is being submitted for
    certification. Firmware must accurately reflect the Make/Model being
    certified.

* GPGPU Devices

  * Systems that are AI/ML focused MUST pass the GPGPU tests in addition to the
    standard test plan for certification. These are systems that ship with
    multiple GPGPUs and are marketed for AI/ML workloads.

Non-Blocking
------------

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

* GPGPU devices

  * Systems that include a GPGPU option but are not AI/ML focused (e.g. systems
    that allow adding one or more GPGPUs into avaialable PCIe slots) will not
    be gated if the GPGPU options have not been tested.

Untested
--------

* Graphics Display Adapters and external monitors

* Tape devices

* Advanced network configuration (Bonding, Failover, etc)

* E-Star requirements

* Sleep states

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
  includes x86_64, ARM, ARM64, PPC64LE and s390x.
  
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

Because of this, please work with your Partner Engineer to outline
and document those tests that are not covered by the standard tooling. 
Partners are strongly encouraged to integrate the Ubuntu test tools and
Ubuntu OS into their own processes for OS and Hardware Validation.  Your
Partner Engineer will gladly help assist you in any way to make
this possible.
