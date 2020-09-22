DiskCart / DiskWriter V1.30

Copyright (C) 2010-2020 by Matthias Reichl <hias@horus.com>

This program is proteced under the terms of the GNU General Public
License, version 2. Please read LICENSE for further details.


About DiskCart
==============

DiskCart allows you to store and use up to 8 disk images of
arbitrary size on flash carts.

Images can be added at a later time, as long as free space is
available on the cart, and can also be written back to disk drives.

The integrated MyPicoDos "cart" version can be used to easily load
programs from the disk images.

On Atari XL/XE computers the disk images can also be booted.

DiskCart was originally written for the 512k Flash Megacart in 2010
and now also supports the 4MB Flash Megacart, 8Mbit AtariMax cart and
the TurboFreezer 2005 and 2011 CartEmus.


Using DiskWriter
================

diskcart.atr contains separate versions of the DiskWriter software
for the supported flash carts. Plug in the flash cart, boot the
diskcart disk (image) and choose the version matching your cart.

After startup it checks if the flash cart is present and if the
cart had been previously initialized with the DiskCart software.

If it can't detect the cart it'll show instructions what to do
(eg on the Turbo Freezer you need to set the Flash Write switch
to "on") and wait for a key-press.

If the cart was already initialized it'll go straight to the main
menu, if not it'll ask you if it should initialize the cart.

The main menu will show the type of flash chip in the cart, the
software version currently present in the cart, highspeed SIO
status (on/off) and the MyPicoDos autostart status of the cart.

Below that it lists the images stored in the cart, the amount
of free space and the menu items.

1) Init flash cartridge / Init CartEmu
--------------------------------------

This option completely erases the flash cart and initializes it
with the DiskCart software.

Note: on the Turbo Freezer 2005 this will use the complete CartEmu
space (banks 0-47). On the Turbo Freezer 2011 you can choose between
using the complete CartEmu space (banks 0-119) or only the first 512k
(banks 0-63). The latter allows you to use banks 64-119 for other purposes.

2) Add disk to cart
-------------------

Use this option to add a new disk image to the cart.

After entering the drive number DiskWriter tries to detect the size
of the disk and checks if enough free memory is available.

Then it asks for an (optional) image name that will be shown in the
list of images and in the DiskCart chooser (when booting the cart).

After that it starts reading the disk and writing it to the cart.

If an error occurs during reading the disk image in the cart will
be flagged as "incomplete data".

3) Write image to disk
----------------------

First enter the number of the image (from the image list above),
then the drive number where the image should be written to.

The software will also ask if the drive should be formatted and
ask for a confirmation before starting the format/write operation.

4) Toggle HISIO on/off
----------------------

DiskWriter uses highspeed SIO for all disk operations by default.
Use this option to disable it, eg when you want to access PBI devices.

5) Enable MyPicoDos autostart
-----------------------------

By default the DiskCart configuration menu will be shown after
powerup. Enabling MyPicoDos autostart bypasses this and immediately
starts the integrated MyPicoDos.

Note: Once enabled it's not possible to disable this option again,
except by re-initializing the flash cart. But MyPicoDos autostart can
be disabled by booting with the SELECT key pressed.

6) Start cartridge
------------------

This exists the DiskWriter program and immediately starts the
DiskCart software in the flash cart.


Using DiskCart
==============

After powerup the DiskCart configuration menu will be shown.
This can be bypassed by pressing OPTION during powerup - this
will temporarily disable the flash cart.

If MyPicoDos autostart has been enabled the integrated MyPicoDos
is automatically activated instead. Pressing SELECT during powerup
disables that and brings up the configuration menu.

Configuration menu
------------------

The middle part of the configuration screen lists the images
stored on the flash cart, along with the image number and name.

The options to start the DiskWriter software and MyPicoDos are
always available, the options to setup image boot are only
displayed when a compatible (XL/XE) OS has been detected.

Starting DiskWriter
-------------------

Pressing "W" starts the integrated DiskWriter software. This is
identical to the version from the diskcart.atr image and allows
you to quickly add new images, write them back or re-initialize
the flash cart without needing to boot software from a disk.

Integrated MyPicoDos
--------------------

Pressing the SPACE key starts the integrated "cart" MyPicoDos.
This MyPicoDos version works (almost) the same as the normal
MyPicoDos versions, except that it gives you access to the
(up to) 8 images stored on the flash cart instead of disk drives.

Pressing "1"-"8" selects one of the 8 images on the flash cart
and pressing "I" shows a list of available images on the cart.

Booting disk images
-------------------

This function is only available when using the stock XL/XE OS
or QMEG 4.04. Other OS versions might work, too, but this has
not been tested.

Boot image access requires copying the OS from ROM into RAM and
patching it, so the same restrictions as for other "soft-OSes"
apply: if some program re-enables ROM then flash image access
will be lost. And if some program (eg TurboBasicXL or SpartaDOS)
uses the RAM under the OS this will crash / lock up the Atari.

Also note that access to flash cart images will be read-only. Only
"read sector", "get status" and "get percom block" SIO commands
are emulated, all other commands will return an error.

Before booting one of the eight images with the "1"-"8" keys
a few settings can be configured:

With "B" you can toggle the built-in BASIC between "on" and "off".

With "D" the drive number used to access the image on the flash
cart can be toggled between "D1:" and "D2:". By setting the drive
number to "D2:" you can boot from a disk in a "real" D1: drive and
eg access the files on the flash cart disk images at D2:


Using atr2cart
==============

atr2cart allows you to create ROM images with DiskCart and (up to)
eight ATR disk images on a PC.

The diskcart distribution includes a pre-compiled Win32 console version
(atr2cart.exe).

If you use linux you have to compile it yourself. Either run
"make atr2cart" in the src directory if you have atasm and xxd
installed (this will also rebuild the Atari binaries) or build it
with "g++ -o atr2cart atr2cart.cpp AtrUtils.cpp Error.cpp" - the
latter only requires a C++ compiler.

If you run atr2cart without any options it'll show a short usage
summary.

To create a ROM image you have to specify the flash cart type
and the name of the ROM file that should be created plus optionally
up to 8 ATR image files. eg:

atr2cart frz11 freezer-dos.rom dos20.atr dos25.atr

You can also enable MyPicoDos autostart by using "-a" - note that this
has to be the very first option. eg:

atr2cart -a frz11 freezer-games.rom games.atr

