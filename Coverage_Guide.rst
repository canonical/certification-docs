===============================================
 Ubuntu Server Hardware Certification Coverage 
===============================================

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

Welcome!
========

The Ubuntu Certification team is continuously revisiting the scope of the
tests comprising the Ubuntu Certified programme and it is reviewed every
six months, following the same cadence as the Ubuntu OS. This revision of
new tests is performed during Ubuntu's development cycle and it never
applies to already-released versions of Ubuntu.

This document was previously tied to specific Ubuntu Server LTS releases.
Going forward, however, it will apply to all Ubuntu LTS releases.  Release
specific versions of this guide will no longer be produced.

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

In previous versions of Ubuntu up to 16.04 LTS, we did not test GPGPUs,  thus
GPGPUs were Untested items.  As of 18.04 LTS, GPGPU testing was introduced as a
tech preview test, which is non-blocking.  As of 20.04 LTS, compute GPUs that
are offered to customers **must** pass GPGPU testing as part of the normal
testing of Vendor Approved Options.

Full test case descriptions can be found at the Canonical Certification
portal for partners:

     http://certification.canonical.com
 
Ubuntu Server LTS Coverage
==========================

As introduced in the 18.04 LTS cycle, Ubuntu LTS certification requires the
testing of Vendor Approved Options in order to meet the requirements of the
Ubuntu Server Certification programme.  This means that all Vendor Approved
Options for sale with a given model Server must be covered by testing at some
point.

Once a Vendor Approved Option has been tested in one Server Model, it does not
need to be retested for another Server Model.  This increases the scope of
testing but minimizes the amount of extra test work necessary.  Thus, if Model A
and Model B both feature Networkcard 1, Networkcard 1 is only required to be
tested once in either Model A or Model B, and will be considered tested for
both.

Blocking Items
--------------
These items must be tested and must pass testing to be considered Certified.

* Installation Methods

  * `Metal as a Service`_ is a required part of server certification testing.
    If a system cannot be automatically enlisted, commissioned, and deployed
    using MAAS **without user interaction other than manually powering the
    system on the first time** the system cannot pass Ubuntu Server
    Certification.  An exception is made here for systems that use management
    engines like Intel AMT that provide no means of in-band configuration and
    thus require manual configuration in MAAS to work.

.. _`Metal as a Service`:
   https://maas.io

* Processors

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time.

  * Currently, the following architectures can be tested:

    * Both Intel and AMD CPU platforms (64-bit only)

    * IBM and OpenPOWER Power 8 and Power 9 (ppc64el)

    * ARM64 (ARM64 based Server Models must use a SoC that has been `SoC
      Certified`_.)
      
    * IBM s390x

    * RISC-V [0]_

    .. [0] When servers using RISC-V become available we will support
       certifying them.

    .. _`SoC Certified`:
       https://ubuntu.com/certified/soc

* Memory

  * Proper detection

  * General usage 

  * A general stress test is performed to verify that the system can handle
    a sustained high load for a period of time.

* Intel Optane DCPMM devices

  * Configuration

  * Intel DCPMMs are tested in both Memory and AppDirect [1]_ (Storage) modes.

    .. [1] fsdax, raw, and sector modes only, devdax is not currently tested.

* Internal storage (RAID **and** Non-RAID) [2]_

  .. [2] Only hardware RAID solutions.

  * Storage devices (HDDs, SSDs, Hybrid, NVMe, RAID LUNs) are I/O load tested
    using open source tools

  * Basic RAID levels (0,1 or 5)

* OCP, Mezzanine, or Daughter Cards

  * Any OCP, mezzanine or daughter card that enables ports on the motherboard must
    pass. (e.g. a mezz card that enables 10Gb on onboard SFP+ ports)

* Networking

  * Ethernet devices are tested at their full speed and must show a minimum of
    80% of advertised maximum speed.

  * High Speed network devices (40 Gb/s and faster must also meet this
    requirement, however additional configuration and testing steps may be
    required)

  * CNAs and Infiniband devices must at least pass in network mode.

* System management [3]_ [4]_

  .. [3] Applicable to systems that ship with a BMC or similar management
         device.
  
  .. [4] Limited to Power Management and User/Password management for MAAS
         control and probing for info from the BMC.

  * In-Band Management (IPMI)

  * Out-of-Band Management (IPMI, AMT, etc)

  * Chassis Management (Blade / Cartridge type systems)

  * Virtual Machine Management (for LPAR or VM systems like Power or z13)

  * MAAS Compatibility

* USB controllers

  * Externally accessible physical USB ports are tested to ensure operability.

  * USB 2.0/3.x

* Boot/Reboot

  * PXE Booting from a MAAS server

  * Rebooting to finalize deployment

* Virtualization [5]_

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

* GPGPU Devices (NVIDIA)

  * Systems that are AI/ML focused, such as those that ship with multiple
    GPGPUs and marketed for AI/ML workloads, **must** pass the GPGPU tests
    in addition to the standard test plan for certification.

  * Any GPGPU that is listed as a Vendor Approved Option for a server model
    must be tested regardless of whether that system is AI/ML focused (e.g. a
    small server that includes a T4 GPU option)

Non-Blocking
------------
These items will not block certification if they fail.  Any failures should be
referred to the Certification Team so that we can investigate and file bugs
where appropriate.

* Installation Methods

  * ISO Installation

* Storage

  * Advanced RAID levels (10, 15, 50, etc)

  * VROC

  * External Storage

    * iSCSI

    * FC, FCoE
  
  * Storage Management Tools

    * Storage management tools packaged and documented for Ubuntu

    * Storage management tools should be fully functional on Ubuntu
      (executable from within Ubuntu)

* Networking

  * SmartNICs 

  * Infiniband

* System Mangement

  * Redfish [6]_

  .. [6] Redfish should be tested where supported, failures should be referred
     to the Certification Team, but IPMI can be used if Redfish fails.

* Firmware Updates

  * Firmware update tools packaged for Ubuntu

  * Firmware updates possible from within the Ubuntu OS

* TPM 2.0 Devices

* Input devices

  * External keyboard (basic functionality)

Untested
--------
These items are not tested as part of Certification currently.  

* Memory

  * Advanced memory configurations

* Storage

  * Optical drives (CD/DVD) are no longer required to be tested

  * Tape devices

* Networking

  * Advanced networking configurations such as bonding, failover, etc

  * Virtualization (VNF, etc)

* Accelerators

    * Non-NVIDIA GPUs

    * FPGA

    * Cryptographic Accelerators

* Graphics Display Adapters and external monitors

* E-Star requirements

* Sleep states

Q & A
=====

What do you mean by MAAS Compatibility?
  In order to be listed as certified, a system is required to have been
  deployed using Ubuntu's Metal as a Service (MAAS) tool. This is determined by
  using MAAS to enlist, commission, and deploy the OS and certification tools
  onto the target systems to be tested. Additionally, there should be as little
  human intervention as necessary to perform this task, such as the user
  manually needing to power the machine on during the initial enlistment phase.

Does changing the speed of processors require a new certificate?
  No. Only changing the CPU family would require retesting and issuing a
  new certificate.

What about non-x86 processors?
  Any architecture supported by Ubuntu may be certified.  At this time, this
  includes x86_64, ARM, ARM64, Power 8, Power 9, s390x, and RISC-V.
 
Complete Test Plan
==================

The Hardware Certification Testing Coverage aims to test as thorough as
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
