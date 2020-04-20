======================================================
 Ubuntu Server Hardware Certification Test Case Guide
======================================================

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

Introduction
============

This guide describes the jobs performed in Ubuntu server certification
testing. A job can be anything executed by Checkbox, typically these are either
information gathering jobs or test cases.

Test cases follow the format Category/TestName such as `ethernet/detect`. Some
job names may simply be a TestName without the category designator. These are
typically jobs that gather and/or attach hardware info for the submission file.

Jobs are grouped into three categories:

mandatory_include
    Items that Checkbox *will* run every time. These jobs can not be skipped.

include
    Items that Checkbox *may* run. These jobs can be skipped depending on the
    presence or absence of certain components, or software.

bootstrap_include
    Items that Checkbox will run before the final test list is created. These
    jobs accomplish tasks such as gathering initial system information that is
    used to determine which test cases are applicable to the SUT.

This guide is based on the `server-full-20.04.pxu` list used for full Server
Certification. Other lists in the `canonical-certification-server` UI are
either subsets of this list, or not applicable to 29.04 certification, such as
the 18.04 lists.

Tests
=====

