==============================================
Internet of Things Certified Hardware Coverage
==============================================

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

This document lists the coverage for certification of Internet of Things (IoT)
devices with Ubuntu images. IoT devices can be certified with the following
image types:

- Ubuntu Core 22
- Ubuntu Server 22.04
- Ubuntu Desktop 22.04

The guide applies to devices submitted to Canonical through one of the
following programmes:

- IoT Devices Enablement Programme with Certification
- IoT ODM Partner Programme
 
The following test categories are specified: 

Blocking
  Features that are required for certification. If any of the 
  tests in the required category fails, the certification will fail.

Non-blocking
  Features that are tested, but that don’t block certification. If any of the 
  tests under the optional category fail, a note will be added to the 
  certificate to warn the potential customer or user. 

Untested
  The items in the Untested category are just reference items.
  Anything not explicitly called out in the Blocking or Non-blocking categories
  can be considered part of the Untested category. We will consider adding 
  more tests as needed.

Note: only categories of hardware are tested and not specific types of 
hardware. For example, tests are run to verify USB controllers work, but the 
type of peripheral(s) used during those tests are not specified. Coverage is 
flexible based on customer requirements (for example, if a device’s use cases 
don’t require LEDs, then LEDs can be untested)

Full test descriptions can be found in Canonical certification site for 
partners:

    http://certification.canonical.com
 

Blocking
========

Audio
-----

Output needs to be undistorted between 0%-100%. Output lines tested:

- Internal speakers
- 3.5mm headphones
- HDMI audio output
- DisplayPort audio output

Input needs to be recorded undistorted between 0%-100%. Input lines tested:

- Internal microphone
- 3.5mm microphone

Plug detection: when a new audio line input or output is plugged in the system,
it needs to be recognized.

Bluetooth
---------

Bluetooth LE (Smart and Smart Ready) is tested for device scanning and pairing.
Apart from pairing, several profiles are specifically tested and required:

- Eddystone Beacon
- HID Over GATT Profile (HOGP), Low-Energy keyboard or mouse with basic functionality

CPU
---

x86_64 and ARM processors are tested to ensure proper functionality. We will 
test specific features as:

- CPU's performance states (frequency up and down in runtime)
- CPU's sleep states (cpu on and off in runtime)
- Running CPU at its maximum frequency

We will also include a general stress test performed for 120 minutes to verify 
that the system can handle a sustained high load for a period of time. This 
test uses the tool “stress-ng” available in the Universe repositories.

For Intel CPU’s, the IPDT (Intel Processor Diagnostic Tool) test suite will be 
run.  The diagnostic checks for brand identification, verifies the processor 
operating frequency, tests specific processor features, and performs a stress 
test on the processor.

Ethernet
--------

Connections are tested for functionality, but not for performance.

Firmware
--------

The Ubuntu image must be installed using the factory default bootloader 
firmware (for example BIOS,  UEFI or uboot as applicable) and with the default 
options (including SecureBoot, if that’s the default setting). Firmware needs 
to be compliant with Canonical Firmware Test Suite (FWTS).

It is recommended that after running Canonical fwts with the list of tests 
defined in the Appendix A, ideally, no CRITICAL or HIGH failures should be 
reported, but those are not automatically certification blockers.

GPIO
----

We test the functionality of individual GPIO lines when the associated 
controller driver in the kernel implements a GPIO Sysfs Interface via the 
gpiolib implementers framework. In such cases, the GPIO system may be tested 
in two ways:

- Direct:

  - GPIO controllers are exposed through sysfs
  - GPIO lines are accessible by the user

- Indirect:
  
  - Communication with device connected via GPIO

I2C
---

All devices attached to the I2C bus must be detectable,  This includes:

- Temperature sensors
- Humidity sensors
- Accelerometers

LEDs
----

When LEDs exist, they will be tested by following some basic expectations here.
The actual behavior may vary depending on the hardware design.  To ensure that 
the behavior is working as expected, please be sure to test against 
specifications obtained from OEM, as each OEM may have different defined 
behavior for LEDs.  The following LEDs are tested:

- Power 
- Serial Port LEDs (indicating activity)

Media Card readers
------------------

Media Card readers are tested for read and write for the following type of 
cards:

- CF
- MMC
- MS
- MSP
- SD
- SDHC
- SDXC
- XD

Memory
------

Proper detection of the amount of memory installed is required (the amount of 
memory installed is the memory seen by the OS).

Monitors
--------

Each of the available external video ports (supported ports are HDMI, 
DisplayPort, DVI) are tested one by one. Output to the display must work i.e. 
a console is presented.

Power Management
----------------

Warm reboot is tested such that the system must be able to perform the reboot 
command and services must be restarted such that systemctl does not identify a 
failed state.

Cold reboot is performed where an RTC is available (see next section). The 
wakealarm is used to reboot the system after a period of rest and services must 
be restarted such that systemctl does not identify a failed state.

Real-Time Clock (RTC)
---------------------

If present on the device, the device must have a working real-time clock. This 
will be tested by scheduling a wake alarm to bring the system up after a halt.

Serial Ports
------------

Tests are carried out on ports that provide access via the Linux tty layer. The
exact tests performed depend on the physical characteristics of the 
driver/receiver hardware. The possible tests include:

- Ensure expected number of devices are available
- Looped tests:

  - RS232 Ports: perform loopback test to ensure RX/TX
  - RS422/485 Ports: connect together to ensure RX/TX

- Machine to Machine tests: confirm that a connection can be made to another 
  PC device and RX/TX is operational

Internal Storage
----------------

All internal storage devices are tested to be properly detected. An in-house 
performance test is run on all disks with read performance of 15MB/s required 
to pass.

USB controllers
---------------

USB 2.0
^^^^^^^

USB storage devices must work on all available USB ports. USB Human Interface 
Devices (HID), specifically keyboard or mouse, should be working properly on 
any USB port.

USB 3.0
^^^^^^^

USB storage devices must work on all available USB ports. USB Human Interface 
Devices (HID), specifically keyboard or mouse, should be working properly on 
any USB port.

USB Type C (USB 3.1)
^^^^^^^^^^^^^^^^^^^^

USB Type C (USB 3.1) supports various types of devices (e.g. Video, Power) 
through the use of adapters or peripherals. The following adapters/peripherals 
should work:

- Storage devices
- Keyboard or mouse (basic functionality)
- When DisplayPort over USB Type-C is advertised:

  - Display hot plugging and the following display are required to work: 
    mirrored, extended, internal only, external only.
  - Audio output needs to be undistorted over this port.

Wireless Networking
-------------------

Wi-Fi interfaces are tested for connection to access points configured for 
802.11 b/g/n/ac/ax protocols.

Wireless Wide Area Network
--------------------------

WWAN interfaces are tested for connection to 3G/4G/LTE services.

Thunderbolt
-----------

Thunderbolt featues tested:

- Audio output must be undistorted over this port.
- Storage devices with hot plugging capability should work when BIOS is set to 
  “No security” option.
- Monitor hot plugging including different modes (mirrored, extended, internal 
  only, external only) are required to work.
- Daisy-chaining devices should work with a storage device and a monitor 
  chained together. 

TPM
---

TPM 2.0 functionality will be tested using FWTS. It is required that all 
commands necessary to support Ubuntu’s Full Disk Encryption functionality are 
supported.

Non-blocking
============

CANBus
------

Devices that support the SocketCAN standard are tested to ensure that the 
adapter is present and can be communicated with via CANBus configuration 
commands.  

Media Card readers
------------------

Media Card readers are also tested for read and write for the following type or
cards: 

- MMC (before and after suspend)

Power Management
----------------

Suspend/Resume
^^^^^^^^^^^^^^

For x86 devices, a 30 cycle suspend/resume stress test is performed using the 
FWTS. The suspend mode (e.g. S3, S2Idle) used during the test will be the 
default for the system under test. The test is passed if all 30 cycles complete
without failure. Any errors reported in the fwts log for the 30 cycle 
suspend/resume stress test are informational only and do not affect the outcome
of the test, however, we do recommend examining and fixing any failures noted, 
as they indicate firmware non-compliance with standards.

In addition a single suspend is performed across which  the following features
and devices are tested:

- CPU
- Memory
- Networking (Wifi, Ethernet)
- Audio
- Bluetooth
- USB controllers
- Input devices
- Mediacards

Watchdog Timer
^^^^^^^^^^^^^^

A test will be performed to verify that any kernel modules needed for watchdog
timers are loaded and working as expected. 

LEDs
----

The following LEDS will be tested for functionality:

- Cloud LED
- Wireless LED
- Bluetooth LED
- WWAN LED

Appendix A. FWTS tests
======================

As part of the certification process, we run a series of firmware tests that 
are part of the Canonical Firmware Test Suite. In general, any HIGH or CRITICAL
error found in the fwts log can cause potential errors in the system and should
be looked at by OEMs/ODMs.

===========   ============   ===========
Category      Test Item      Description
===========   ============   ===========
Information   acpidump       Check ACPI table acpidump
Information   version        Gather kernel system information
ACPI          acpitables     ACPI table settings sanity checks
ACPI          apicinstance   Check for single instance of APIC/MADT table
ACPI          hpet_check     High Precision Event Timer configuration test
ACPI          mcfg           MCFG PCI Express* memory mapped config space
ACPI          method         ACPI DSDT Method Semantic Tests
CPU           mpcheck        Check Multi Processor tables
CPU           msr            CPU MSR consistency check
CPU           mtrr           MTRR validation
System        apicedge       APIC Edge/Level Check
System        klog           Scan kernel log for errors and warnings
===========   ============   ===========

