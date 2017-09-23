MyPicoDos 4.06

Copyright (C) 1992-2017 by Matthias Reichl <hias@horus.com>

This program is proteced under the terms of the GNU General Public
License, version 2. Please read LICENSE for further details.

0. IMPORTANT NOTE:

Starting with V4.05 the builtin highspeed SIO support can be activated
during booting. While this reduces boot time on enhanced floppies,
SIO2PC, SIO2SD etc, booting from (PBI) harddrives or (PC) Atari emulators
might fail. In this case PRESS SELECT while booting to disable
highspeed SIO.


1. What is MyPicoDos

MyPicoDos is a "game-DOS" for DOS 2.x/MyDOS compatible disks with
the following features:

- It supports loading of COM/EXE, BIN (boot image) and BAS files.
- It works with single and double density (hard-) disks from
  720 up to 65535 sectors.
- Drives D1: to D8: can be accessed.
- It supports MyDOS style subdirectories.
- It supports Bibo-Dos style long directories (128 files per disk).
- It supports XF551 format detection.
- Builtin highspeed SIO code: compatible with ultra speed (Happy, Speedy,
  AtariSIO/SIO2PC/APE/...), Happy 810 Warp Speed, XF551 and Turbo 1050,
  up to 126 kbit/sec (Pokey divisor 0)
- It supports displaying long filenames and a disk/directory title.
- On XL/XE-type computers MyPicoDos can automatically switch basic on
  when loading a basic program, and switch basic off when
  loading a COM/EXE/BIN file.
- Joystick support: either use arrow keys or a joystick to select
  the file, switch directories or drives.
- Optional builtin atariserver (AtariSIO) remote console.
- Separate "barebone" version without highspeed SIO support and
  remote console support (for those who want to save space)
- Separate boot-sector-only version "PicoBoot" supporting a single
  COM file on a disk
- Separate "SDrive" version which configures the SDrive to use
  110 or 126 kbit/sec transfer speed.


2. Using MyPicoDos

- Load the MyPicoDos initializer (MYINIT.COM, MYINITR.COM, MYINITB.COM
  or MYINITS.COM) from the myinit.atr image and write MyPicoDos to a disk.

  Note: You must load it from a real DOS (not a gamedos!),
  because the initializer will use the DOS functions to create
  a file named PICODOS.SYS on the disk!

  In the initializer you can choose if and when you want to
  use the builtin highspeed SIO code (unless you are using the
  barebone version, which contains no highspeed code, or if you
  are using the SDrive version, which defaults to highspeed enabled
  at boot time). There are 3 possibilities:

  * HighSpeed at boot: enables highspeed while booting MyPicoDos,
    automatic fallback to standard OS SIO in case of errors.
    Use this setting if you mainly work with enhanced floppies,
    SIO2PC, SIO2SD etc.

    Pro: faster booting if you use an enhanced floppy drive or SIO2PC.
    Con: booting might fail with non-SIO devices (like most harddrives)
         and on emulators (until emulators fix their POKEY emulation).
         Press SELECT while booting to disable highspeed SIO in this case.

  * HighSpeed auto: enable highspeed after MyPicoDos is booted, fallback
    to standard SIO in case of errors.
    Use this setting for ATR images easily usable both on SIO devices,
    harddrives and emulators.

    Pro: MyPicoDos is bootable from all devices and on emulators.
         Programs are still loaded in highspeed.
    Con: Booting takes longer on enhanced floppies / SIO2PC...
         Harddrive/emulator users may have to disable highspeed SIO
         (by pressing 'H') in the menu.

  * Highspeed off: highspeed SIO disabled, can be enabled in the menu.
    Use this setting if you mainly use (PBI) harddrives or emulators.

    Pro: Fully compatible with all devices and emulators.
    Con: Floppy / SIO2PC users have to manually enable highspeed SIO
         each time they want to load a program in highspeed.

  The image "myinit.atr" contains also MyDOS, so just load it
  into AtariSIO/APE/SIO2PC/... or into your favourite
  Atari emulator.

- Use one of the supplied mypdos*.atr files with your emulator
  or AtariSIO/SIO2PC/...  program. After booting one of these
  ATR-files, MyPicoDos will automatically switch to D2:.
  So you may simply load the mypdos ATR-image into D1: and another
  ATR image with your files into D2: and don't need to create
  a MyPicoDos boot disk by yourself.

- Use the standalone MYPDOS*.COM versions of MyPicoDos on the
  myinit.atr image. These files can be loaded directly from DOS.

The initializer is avaliable in 4 versions:
- default, without atariserver remote console (MYINIT.COM)
- with atariserver remote console (MYINITR.COM)
- special SDrive version (MYINITS.COM)
- barebone (MYINITB.COM)

The standalone .COM version and the directly bootable ATR files
are available in 5 configurations:
- barebone (mypdosb.atr/MYPDOSB.COM)
- no remote console, highspeed auto (mypdos.atr/MYPDOS.COM)
- no remote console, highspeed off (mypdosn.atr/MYPDOSN.COM)
- remote console, highspeed auto (mypdosr.atr/MYPDOSR.COM),
- remote console, highspeed off (mypdosrn.atr/MYPDOSRN.COM).

At the MyPicoDos main screen just use the cursor keys (with or
without control) to select the file you want and press "Return" to
load it.

When you load a file, MyPicoDos will automatically try to
enable/disable the built-in Basic on XL/XE computers, depending on
the filetype. You may disable this feature by loading a file with
"SHIFT-Return" instead of "Return".

Use the keys "1" to "8" to switch to drive D1: to D8:.

MyDOS subdirectories are marked with a ">" in front of it. Just
press enter to open a selected directory. To leave a directory
(and return to the parent directory) press "Escape".

You can also use a joystick (either plugged into port 1 or 2)
to move the cursor and press fire to select a file or directory.

To go up to the parent directory press and hold fire, then push
up and release fire. Fire+down switches to the root directory,
fire+left/right decreases/increases the drive number.

To change up multiple directory levels or through multiple drive
numbers hold the fire button, push the stick into the desired
direction, then move the stick to the center position, then push it
again into the desired direction etc. When you are done release the
fire button and you're back in cursor movement mode.

MyPicoDos is also compatible with the APE PC Mirror function.
Subdirectories are prefixed with a "\", to go back to the parent
directory select "\UP" - using escape works only for MyDOS
subdirectories. If APE is running on a slow computer you might
get a "disk error" after entering a directory. In this case,
just use "1".."8" to re-read the PC Mirror drive.

Use the "L" key to disable the long-filename display, eg when
you'd like to see all files on a disk.

In case the disk format recognition did not work correctly, you
can use the "F" key to manually set the format (read below for
details).

Use the "H" key to enable/disable the built-in highspeed SIO code.

Use "A" to start the builtin atariserver (AtariSIO) remote console.
Just enter atariserver commands (similar to "telnet"), or press
"break" to exit the remote console. Please note: At the time of
writing this document I haven't officially released a version of
AtariSIO with remote console support!


3. Using PicoBoot

The main goal of PicoBoot is to create auto-booting disks, without
having to convert the COM/EXE file to some non-standard format.

PicoBoot is an extremely stripped-down version of MyPicoDos
that fits into the 3 boot sectors of a disk. It simply loads
the very first file on the disk, assuming it is a standard
COM/EXE/XEX file.

PicoBoot doesn't to any checks (if the file exists, if it
really is a COM file etc), doesn't disable basic and also doesn't
include highspeed SIO support. But it supports both single and
double density images, up to 16MB.

To initialize a disk, load PICOBOOT.COM and enter the drive number.
The initializier program than writes the PicoBoot code to the 3
boot sectors. It doesn't matter if there's already a COM file on
the disk, you may also initialize a blank-formatted disk and copy
the COM file later. The initializer program may also be loaded from
a "gamedos", it doesn't need any DOS functions.

After the three boot sectors are loaded, PicoBoot sets up the
COM loader code with the information found in the first directory
entry: it checks status bit 2 of the file to determine if
the file uses 10bit or 16bit sector links and reads the starting
sector number from the directory entry. Then it starts the COM loader.


4. Some remarks about the builtin highspeed SIO code

In general I'd recommend using the version of MyPicoDos that has
highspeed SIO set to auto, so that you can access all of your
floppy drives and also AtariSIO/SIO2PC/APE/... at the highest
possible speed.

One drawback of the builtin highspeed SIO code is that it completely
bypasses the SIO routine of the OS and accesses the SIO bus
directly. If you are using a harddisk interface (like MyIDE, KMK/JZ,
BlackBox etc), you won't be able to access your harddrive unless
you disable the builtin highspeed SIO code.

If you are using an emulator (like Atari800), you may experience
problems with disk images larger than 32768 sectors if highspeed
SIO is enabled. This is due to the incomplete POKEY emulation in
most Atari emulators. The highspeed code misdetects the drive
as a "1050 Turbo" and then sets bit 7 of DAUX2 to indicate highspeed
transmission. This is no problem if the image has less than 32768
sectors, in this case the emulator reports an error and MyPicoDos
switches back to standard OS SIO. But if the image has more than
32768 sectors, the emulator will happily return the wrong sector
(for example sector 33128 instead of 360).

Most emulators patch the OS ROM so that accessing a disk drive will
be a lot faster. In this case, disable highspeed SIO to get the full speed.

Another drawback of the builtin highspeed SIO code is that it needs
some 550 bytes of memory (exactly: $0935-$0B60). If you want to load
a program which also uses this memory locations, your Atari will crash.
If you disable the highspeed SIO code, this memory is free. You'll have
to keep this in mind, especially when loading .BIN (boot) files. Most
of these files have a very low starting address ($0700 or even lower).
The .BIN-loader of MyPicoDos is relocated to $80 so that it doesn't
conflict with .BIN files. If you disable highspeed SIO, all .BIN files
should load fine.

All "Highspeed boot/auto/off" versions are identically, except for a
single byte which selects the default highspeed setting at startup.
This is the 16th byte of sector 1. A value of 0 means "off", 1 means
"auto" and $81 means "boot".

BTW: The highspeed SIO code is quite smart. Before loading a program
MyPicoDos checks if the drive really supports highspeed SIO mode.
If the drive only supports standard SIO mode, the highspeed code
is automatically turned off.


5. Long filenames and disk/directory titles support

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

In case you'd like to see what's really on the disk, you can
disable the long filename display with the "L" key. If you want
to remove all long filenames completely, just delete the file
PICONAME.TXT.

Please note: a maximum of 100 long filenames is supported per
directory. This is no limitation for MyDos/DOS2.x format disks,
which can contain a maximum of 64 files per directory, only
BiboDos is able to store 128 files per directory on a QD (360k)
disk - so, in general, this should not be a real limitation.

5.1 Creating/editing long filenames with the initializer program

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

Please note: If you want to edit the long names for a BiboDos QD
disk you have to start the MyPicoDos initializer from BiboDos.
The initializer program uses the standard DOS routines to read the
directory of a disk, and all other DOSses except BiboDos only
handle 8 entries per directory sector (compared to 16 entries
in BiboDos QD format).

5.2 Creating the PICONAME.TXT file by hand

The file format of the PICONAME.TXT file is quite simple:
it is a plain ATASCII file separated by returns (character 155).

The first line contains the title of the disk/directory
(up to 38 characters).

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


6. Usage hints

In the MyPicoDos initializer, you can abort the current operation
by pressing the break key.

Anytime you have completed or aborted an operation, just press
any key to return to the main initializer menu.

MyPicoDos uses a XF551 compatible way to determine the disk density:

First it reads sector 4 (this is required by the XF551), and then
it uses the "get status command" to see whether the disk is single
or double density.

If the disk format is set to "auto", bit 2 of the file status byte
in the directory entry determines if the file uses DOS2.x 10-bit
sector chaning (bit 2 = 0) or if it uses MyDOS 16-bit sector chaining
(bit 2 = 1).

In case the disk format autodetection fails, please set it manually
using the "F" key.

The density (SD or DD) used in the format code actually refers to
the sector length (SD is 128 bytes per sector, DD is 256 bytes
per sector) and should not be confused with the SD/ED/DD/QD/... disk
formats.


7. Compiling the sources

First of all, you don't need to compile MyPicoDos yourself, you
may simply use the provided .COM and .ATR files.

The source files in the src subdirectory (*.src, *.inc) are in
Atasm format. Atasm is a MAC/65 compatible cross-assembler, so it
might be possible to change the source code for use on a real Atari.
Please note: use Atasm version 1.05 or higher!

The supplied Makefile works with unix/linux systems, if you are using
a different platform you might have to change it.

To avoid troubles with DOS/Windows based editors, all files have
been saved in DOS format (CR LF at the end of each line).

The file "mypdos.src" is the main source file. It contains the
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
$0800-$0854 contains the basic disk IO code to read bytes (used by
            the COM and the BAS loader)
$0855-$0929 is either used by the COM or the BAS loader. The filetype
            is determined by mypdos, and the appropriate loader code
            is then copied there. Actually, the BAS loader only
            uses memory up to $08A8.
$092A-$0BE3 contains the highspeed SIO code.

$1000-$2400 (approx.) is used by mypdos

$3000-$6500 is the data area of mypdos (see mypdos.src for details)

The highspeed SIO code assumes that the COM loader is longer than
the BAS loader, and therefore includes the comloadcode.src file
to get the end address of the COM loader (which the highspeed
code uses as it's starting address).

Furthermore, the current copy routine (COP768) which is used to
copy rread, comload, basload, and highspeed into place is limited
to 768 bytes. So, you'll have to change it if your code gets
bigger than that.

The file "myinit.src" is the initializer code which writes MyPicoDos
to disk and also contains the long filename editor. This file
also includes "mypdos.bin".

The file "mypdos-com.src" is for the "standalone" .COM version of
MyPicoDos. It includes either mypdos-code.bin or mypdos-code-hioff.bin
(depending on the "HIDEF" setting).

The file "getdens.src" contains the density-detection source code
and is used (included) by both mypdos.src and myinit.src.

The file "longname.src" contains some basic routines for handling
long filenames, and is used by mypdos.src and myinit.src.

"qsort.src" is an implementation of the quicksort algorithm
and is used by myinit.src to sort the long filenames.

"cio.inc" (used by mypdos.src and myinit.src) contains some macros
for CIO calls.

Finally, "common.inc" contains the definition of the starting address
plus some buffers used by mypdos.src, and is used by mypdos and
the loader and highspeed codes.

Sorry, the source code does not contain many comments. When I wrote
the first versions of MyPicoDos on my Atari 800XL using ATMAS II
(back in the early '90s) memory was quite short and there was not
much space left for comments...

If you've got any questions or if you have problems with MyPicoDos,
feel free to contact me by email!


8. Credits

Thanks go to:

Andreas Magenheimer, Michael Tietz and many others for testing,
bug reports and sending me hints!

Crash and Forrest from the Atarimax forum for donating a MyIDE
interface!

9. Changelog

version 3.0:
- Initial GPL release.
- Support for 128-bytes-per-sector disks.
- Support for disks smaller than 1024 sectors.

version 3.1:
- Rewrote density-check code to fix XF551 density recognition bug.
- Fixed manual density selection code.
- Added drive number selection to MyPicoDos initializer program.
- Fixed old-OS bug in initializer program.
- Added support for "large" Bibo-Dos directories (128 Files).
- Fixed DOS2.5-format file display bug.

version 4.0:
- Added support for long filenames in PICONAME.TXT.
- Many changes in the internal structure to lower the
  memory usage of the BAS and COM loader.
- Created separate "highspeed" and "standard SIO" versions.
  The highspeed version now contains a built-in Happy/Speedy/
  AtariSIO/SIO2PC/APE/... - compatible highspeed-SIO routine
- Added long filename editor to init-program with support to
  read existing long names and with an option to alphabetically
  sort the long filenames,
- "PICODOS.SYS" and "PICONAME.TXT" are excluded from the
  directory listings.
- Internal basic can be automatically switched off when loading
  COM/EXE/BIN files, and switched on when loading BAS files.
- Added "smart" highspeed mode: the built in highspeed code is
  automatically disabled in case a drive doesn't support
  highspeed SIO.
- Used memory is now fully cleared before loading a file.
- Fixed system crash with some Basic programs.
- Fixed XF551 boot problems with QD disks.

version 4.01:
- Bugfix: Write protected directories were not displayed.
- Pressing reset will now result in a cold-start instead of
  activating the selftest/memopad.

version 4.02:
- Fixed corrupted screen in standard SIO version.

version 4.03:
- Added joystick support.
- Bugfix: Fixed KMK/JZ IDE interface problems in initializer program.

version 4.04:
- Added support for Turbo 1050, XF551 and 810 Happy highspeed SIO
- Added atariserver remote console support
- Fixed MyIDE density recognition problems
- New "standalone" .COM version of MyPicoDos (can be loaded from DOS)
- In AUTO disk format mode the file status bit 2 is used to activate
  16-bit sector links
- APE PC-Mirror subdirectories are now handeled properly
- Changed screen layout so that the file display is 15 instead of 12
  lines, added arrow indicators if more files are available by
  scrolling up/down
- Major code cleanup to reduce the size of MyPicoDos
- Added configurable "autorun" feature: if enabled and only one
  file is present, it will be loaded automatically
- Added "barebone" version without highspeed SIO and remote console

version 4.05:
- Added boot-sector-only version "PicoBoot"
- Updated highspeed SIO code to latest version (1.30)
- Added option to enable highspeed SIO while booting MyPicoDos
- Added fallback to OS SIO in case of highspeed SIO errors while
  booting MyPicoDos
- Added SDrive version

version 4.06:
- Added .CAR file loader for The!Cart and Freezer 2011 versions
  of MyPicoDos
- Disable atract mode when using joystick navigation
- Added directory and drive switching using joystick
- Bugfix: don't disable highspeed SIO if reading a directory fails
