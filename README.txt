MyPicoDos 4.0

Copyright (C) 1992-2004 by Matthias Reichl <hias@horus.com>

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
- It supports Bibo-Dos style long directories (128 files per disk).
- Since version 3.1 it supports XF551 format detection.
- It is available in a standard SIO version and in a
  highspeed SIO version which comes with built-in highspeed
  SIO code (compatible with Happy/Speedy/AtariSIO/SIO2PC/APE/...).
- It supports the display of long filenames and a
  disk/directory title.
- On XL/XE-type computers MyPicoDos automatically switches basic on
  when loading a basic program, and it switches basic off when
  loading a COM/EXE/BIN file.


2. Using MyPicoDos

Basically, there are two different ways to use MyPicoDos:

- Load the MyPicoDos initializer (MYPDOS.COM) from DOS and write
  MyPicoDos to a disk. Note: You must load it from a real DOS
  (not a gamedos!), because the initializer will use the
  DOS functions to create a file named PICODOS.SYS on the disk!
  In the initializer you can choose if you want to write the
  standard or the highspeed version to disk.
  The image 'myinit.atr' contains both MyDos and MYPDOS.COM, so
  you just have to load it into AtariSIO/APE/SIO2PC/... or
  into your favourite Atari emulator.

- Use the supplied mypdos.atr (standard version) or mypdoshs.atr
  (highspeed version) files with your emulator or AtariSIO/SIO2PC/...
  program. After booting these ATR-files, MyPicoDos will
  automatically switch to D2:. So you may simply load one of these
  ATR-images into D1: and another ATR image with your files into D2:
  and don't need to create a MyPicoDos boot disk by yourself.


3. Differences between standard and highspeed versions

The standard version does not include the highspeed SIO code and
is therefore somewhat smaller than the highspeed version. Use this
version if either none of your drives is highspeed-capable or if
you intend to use MyPicoDos with an Atari emulator. The standard
version will load a lot faster in emulators, because the
"SIO-patch" of the emulator can be used.

If your disk drives are highspeed capable, or if you use an Atari
peripheral emulator like AtariSIO/SIO2PC/APE/... you may want to
use the highspeed version - because it is faster :-)

One of the drawbacks of the highspeed version is that the highspeed
SIO code needs some additional 500 bytes of memory. If you run into
trouble (eg if your Atari crashes when you try to run a program),
you can disable the highspeed SIO code from within MyPicoDos by
pressing the 'H' key. In this case, you'll have exactly the same
amount of free memory as with the standard MyPicoDos version!

When loading BIN files, MyPicoDos relocates the loader to $80.
So, if you disable the high speed SIO routine, all BIN files should
load fine.


4. Long filenames and disk/directory titles support

By default MyPicoDos displays the directory in a short format
(8.3 filenames).

If MyPicoDos finds a file named PICONAME.TXT in a directory, it
will read the disk/directory title and the long filenames from it.

MyPicoDos displays the long filenames in the same order as they
appear in the PICONAME.TXT file. So you can easily arrange the
order by simply editing PICONAME.TXT by hand.

Only file found both in the directory _and_ in the PICONAME.TXT
file are shown. So, if you add another file, be sure to update
the PICONAME.TXT file, otherwise it won't appear in the listing.
On the other hand, you can simply hide files by omitting them
in the PICONAME.TXT file.

Please note: a maximum of 100 long filenames is supported per
directory. This is no limitation for MyDos/DOS2.x format disks,
which can contain a maximum of 64 files per directory, only
BiboDos is able to store 128 files per directory on a QD (360k)
disk - so, in general, this should not be a real limitation.

4.1 Creating/editing long filenames with the initializer program

First of all, the initializer program will ask you to enter
the drive/directory for which you would like to create or edit
the long filename definitions. The drive/directory must either
be a standard drive specification (eg "D:" or "D2:"), or a
standard MyDos directory specification (eg "D:SUBDIR:" or
"D2:GAMES:ACTION:"). In any case: if the drive/directory entered
does not end in a colon (":"), the initializer won't accept it.

Next, the initializer will search for an existing PICONAME.TXT
file and load it. All definitions found in this file will be
used as default values for the filename and title inputs.
So, if you add a new file to a disk, you don't have to enter
all long filenames again.

Then the initializer will read the directory and ask for a
long name for each of the files.

When you are finished with it, you can tell the initializer to
sort the long filenames alphabetically.

At last, you are asked for a disk/directory title, which
will appear right above the filename listing in MyPicoDos.

4.2 Creating the PICONAME.TXT file by hand

The file format of the PICONAME.TXT file is quite simple:
it is a plain ATASCII file separated by returns (character 155).

The first line contains the title of the disk/directory
(up to 40 characters).

The following lines contain the DOS filename, followed by a space
(character 32) and the long filename (up to 38 characters).

The DOS filename is stored in exactly the same way as in
the directory: 8 bytes for the filename and 3 bytes for the
extender. If the filename and/or the extender is shorter
than 8/3 characters, the remaining space is filled with blanks.

A file named "GAME.BAS" is stored as "GAME    BAS", a file
named "PACMAN.1" is stored as "PACMAN  1  ".

So, the filename must _always_ be exactly 11 characters long.

An example PICONAME.TXT file might look like:

my favourite games
PACMAN  COM Pac Man
DIMENSIONX  Dimension X
BOULDERD1   Boulder Dash 1
BOULDERD2   Boulder Dash 2

So, it's really quite simple :-)


5. Usage hints

In the MyPicoDos initializer, you can abort the current operation
by pressing the break key.

Anytime you have completed or aborted an operation, just press
any key to return to the main initializer menu.

MyPicoDos uses a XF551 compatible way to determine the disk density:

First it reads sector 4 (this is required by the XF551), and then
it uses the 'get status command' to see whether the disk is single
or double density.

Next, MyPicoDos reads the VTOC and checks if the first byte (this
is the 'DOS version' byte) is 3 or greater. If yes, the MyDos format
will be used. If the first byte is 0, 1, or 2, standard DOS 2.x
format is used.

If the auto-detection fails, you can set the format manually using
the 'F' key.

The difference between DOS 2.x and MyDOS format is that MyDOS uses
two bytes (16 bit) for storing the sector chaining, whereas DOS 2.x
only uses the lower 10 bit for sector chaining and the upper 6 bit
to store the file number. These upper 6 bit have to be masked out in
DOS 2.x format.


6. Compiling the sources

First of all, you don't need to compile MyPicoDos yourself, you
may simply use the provided MYPDOS.COM, myinit.atr, mypdos.atr,
and mypdoshs.atr files.

The source files in the src subdirectory (*.src, *.inc) are in
Atasm format. Atasm is a MAC/65 compatible cross-assembler, so it
might be possible to change the source code for use on a real Atari.

The supplied Makefile works with unix/linux systems, if you are using
a different platform you might have to change it.

To avoid troubles with DOS/Windows based editors, all files have
been saved in DOS format (CR LF at the end of each line).

The file 'mypdos.src' is the main source file. It contains the
menu-selector and the some of the loader code.

The loader code is stored in three (actually six) separate files:
rread(code).src, comload(code).src, and basload(code).src. Due
to some limitations in the include-file handling of Atasm it was
necessary to separate the code and some include/options statements
into separate files.

The highspeed SIO code is stored in highspeed(code).src.

The loader code is assembled to run from address $800 upwards,
but the MyPicoDos menu is located at $1000 upwards.

So, what I basically did was the following: assemble the loader
and highspeed codes separately, without a COM file header, and the
use the ".incbin" statement of Atasm to include the code into
mypdos.src. Furthermore, mypdos.src also includes the source code
of the loader and highspeed codes, but with ".OPT NO OBJ", to just
get the label references.

It might sound a little bit complicated, but you don't have to care
too much about that. What is important, is that you know something
about the memory layout:

$0700-$07FF is used as a sector buffer (except for the BIN loader).
$0800-$0858 contains the basic disk IO code to read bytes (used by
            the COM and the BAS loader)
$0859-$0934 is either used by the COM or the BAS loader. The filetype
            is determined by mypdos, and the appropriate loader code
            is then copied there. Actually, the BAS loader only
            occupies memory up to $08A4.
$0935-$0B49 contains the optional highspeed SIO code.

$1000-$2300 (approx.) is used by mypdos

$3000-$6500 is the data area of mypdos (see mypdos.src for details)

The highspeed SIO code assumes that the COM loader is longer than
the BAS loader, and therefore includes the comloadcode.src file
to get the end address of the COM loader (which the highspeed
code uses as it's starting address).

Furthermore, the current copy routine (COP768) which is used to
copy rread, comload, basload, and highspeed into place is limited
to 768 bytes. So, you'll have to change it if your code gets
bigger than that.

The file 'myinit.src' is the initializer code which writes MyPicoDos
to disk and also contains the long filename editor. This file
also includes 'mypdos.bin' and 'mypdoshs.bin', the standard
and highspeed versions of MyPicoDos.

The file 'mypdosatr.src' actually is just a workaround since older
versions of Atasm did not support setting the output file on the
command line. All it does is defining MYPDOSATR to 1 and including
the file mypdos.src.

The file 'getdens.src' contains the density-detection source code
and is used (included) by both mypdos.src and myinit.src.

The file 'longname.src' contains some basic routines for handling
long filenames, and is used by mypdos.src and myinit.src.

'qsort.src' is an implementation of the quicksort algorithm
and is used by myinit.src to sort the long filenames.

'cio.inc' (used by mypdos.src and myinit.src) contains some macros
for CIO calls.

Finally, 'common.inc' contains the definition of the starting address
plus some buffers used by mypdos.src, and is used by mypdos and
the loader and highspeed codes.

Sorry, the source code does not contain many comments. When I wrote
the first versions of MyPicoDos on my Atari 800XL using ATMAS II
(back in the early '90s) memory was quite short and there was not
much space left for comments...

If you've got any questions or if you have problems with MyPicoDos,
feel free to contact me by email!


7. Changelog

version 3.0:
- initial GPL release
- support for 128-bytes-per-sector disks
- support for disks smaller than 1024 sectors

version 3.1:
- rewrote density-check code to fix XF551 density recognition bug
- fixed manual density selection code
- added drive number selection to MyPicoDos initializer program
- fixed old-OS bug in initializer program
- added support for "large" Bibo-Dos directories (128 Files)
- fixed DOS2.5-format file display bug

version 4.0:
- Added support for long filenames in PICONAME.TXT
- Many changes in the internal structure to lower the
  memory usage of the BAS and COM loader
- Created separate "highspeed" and "standard SIO" versions.
  The highspeed version now contains a built-in Happy/Speedy/
  AtariSIO/SIO2PC/APE - compatible highspeed-SIO routine
- Added long filename editor to init-program with support to
  read existing long names and with an option to alphabetically
  sort the long filenames
- "PICODOS.SYS" and "PICONAME.TXT" are excluded from the
  directory listins
- Internal basic will automatically be switched off when loading
  COM/EXE/BIN files, and will be switched on when loading
  BAS files

