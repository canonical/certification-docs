Installing the Ubuntu Desktop image
===================================

Hardware and software requirements
----------------------------------

- A USB 2.0 or USB 3.0 flash drive (8GB min)
- The latest Ubuntu Desktop LTS image for the appropriate release downloaded
  from one of the following locations:

  - https://cdimage.ubuntu.com/focal/daily-live/current/ (20.04)
  - http://cdimage.ubuntu.com/bionic/daily-live/current/ (18.04)
  
- The target device (SUT)
- USB keyboard & mouse
- Monitor and HDMI/DP cable
- Network connection with Internet access (for system update)

Create Ubuntu desktop USB installer
-----------------------------------

Tutorials have been created to guide the user through the process of creating
install media for Ubuntu Desktop. Follow the appropriate tutorial for the
system you are working from:

- Create a bootable USB stick on Ubuntu: https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-ubuntu
- Create a bootable USB stick on Windows: https://tutorials.ubuntu.com/tutorial/tutorial-create-a-usb-stick-on-windows

Install Ubuntu Desktop on the target device
-------------------------------------------

The following tutorial guides a user through the Ubuntu Desktop installer,
however please read the list of configuration requirements:

.. class:: center

https://ubuntu.com/tutorials/install-ubuntu-desktop#1-overview 

Configuration requirements:

- Login details section > Log in automatically

  - During testing it is necessary for there to be an active desktop session,
    therefore when installing the image and creating the user the option “Log
    in automatically” should be selected.

.. raw:: pdf

   PageBreak

