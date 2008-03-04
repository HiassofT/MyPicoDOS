MyPicoDos 3.1

Copyright (C) 1992-2003 Matthias Reichl <hias@horus.com>

This program is proteced under the terms of the GNU General Public
License, version 2. Please read LICENSE for further details.


1. What is MyPicoDos

MyPicoDos is a "game-DOS" for DOS 2.x/MyDOS compatible disks with
the following features:

- It supports loading of COM/EXE, BIN (boot image) and BAS files.
- It works with single and double density (hard-) disks from
  720 up to 65535 sectors.
- Drives D1: to D8: can be accessed.
- It supports MyDOS style subdirectories.
- It supports Bibo-Dos style long directories (128 files per disk)
- Since version 3.1 it supports XF551 format detection
- It is able to use a high speed SIO routine provided by the
  disk drive (works with all drives implementing the SIO commands
  $68 and $69, eg. the Speedy 1050 or the HDI).


2. Using MyPicoDos

Basically, there are two different ways to use MyPicoDos:

- Load the MyPicoDos initializer (MYPDOS.COM) from DOS and write
  MyPicoDos to a disk in D1:. Note: You must load it from a
  real DOS (not a gamedos!), because the initializer will use the
  DOS functions to create a file named PICODOS.SYS on the disk.
  The image 'myinit.atr' contains both MyDos and MYPDOS.COM, so
  you just have to load it into AtariSIO/APE/SIO2PC/...

- Use the supplied mypdos.atr file with your emulator or
  SIO2PC/AtariSIO program. After booting mypdos.atr, it will
  automatically switch to D2:. So you may simply load mypdos.atr
  into D1: and another ATR image with your files into D2: and
  don't need to create a MyPicoDos boot disk by yourself.


3. Usage hints

The maximum allowed size of the high speed SIO routine is 768
bytes. If the routine provided by the drive is larger than that,
it won't be loaded.

If MyPicoDos crashes when loading a COM or BIN file, try disabling
the high speed SIO routine to save some 500-600 bytes of memory. If
it still crashes, it might be that the COM file uses very low memory
and parts of MyPicoDos are overwritten...

When loading BIN files, MyPicoDos relocates the loader to $80.
So, if you disable the high speed SIO routine, all BIN files should
load fine.

MyPicoDos uses a XF551 compatible way to determine the disk density:

First it reads sector 4 (this is required by the XF551), and then
it uses the 'get status command' to see whether the disk is single
or double density.

Next, MyPicoDos reads the VTOC and checks if the first byte (this
is the 'DOS version' byte) is 3 or greater. If yes, the MyDos format
will be used. If the first byte is 0, 1, or 2, standard DOS 2.x
format is used.

If the auto-detection fails, you can set the format manually using
the 'f' key.

The difference between DOS 2.x and MyDOS format is that MyDOS uses
two bytes (16 bit) for storing the sector chaining, whereas DOS 2.x
only uses the lower 10 bit for sector chaining and the upper 6 bit
to store the file number. These upper 6 bit have to be masked out in
DOS 2.x format.


4. Compiling the sources

First of all, you don't need to compile MyPicoDos yourself, you
may simply use the provided MYPDOS.COM, myinit.atr and mypdos.atr files.

The source files in the src subdirectory (mypdos.src, myinit.src,
and mypdosatr.src are in Atasm format. Atasm is a MAC/65 compatible
cross-assembler, so it might be possible to change the source code
for use on a real Atari.

The supplied Makefile works with unix/linux systems, if you are using
a different platform you might have to change it.

To avoid troubles with DOS/Windows based editors, all files have
been saved in DOS format (CR LF at the end of each line).

The file 'mypdos.src' is the main source file. It contains the
menu-selector and the loader code.

The file 'myinit.src' is the initializer code which writes MyPicoDos
to disk. Note: if you change something in mypdos.src, change
MYPDLEN at the very beginning of myinit.src to the length of
mypdos.bin minus 6 (the length of the COM header)! If MYPDLEN is
larger than the real size of mypdos.bin (minus 6), it won't hurt,
you'd just get a larger PICODOS.SYS file on the disk. But if it
is smaller, you'll run into big troubles, because only a part
of MyPicoDos will get written to PICODOS.SYS!

The file 'mypdosatr.src' actually is just a workaround since
Atasm currently does not support setting the output file on the
command line. All it does is defining MYPDOSATR to 1 and including
the file mypdos.src.

If you want to create the 'myinit.atr' file, create a directory
called 'initdisk', copy the DOS.SYS and DUP.SYS files of MyDos
into it, and type 'make myinit.atr'.

Sorry, the source code does not contain many comments. When I wrote
the first versions of MyPicoDos on my Atari 800XL using ATMAS II
(back in the early '90s) memory was quite short and there was not
much space left for comments...

If you've got any questions or if you have problems with MyPicoDos,
feel free to contact me by email!

so long,

Hias
