# 
# MyPicoDos V4.0 Makefile (c) 2003-2004 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

all: MYINIT.COM MYINITR.COM \
	MYPDOS.COM MYPDOSN.COM \
	MYPDOSR.COM MYPDOSRN.COM \
	MYPDOSB.COM PICOBOOT.COM \
	mypdos.atr mypdosn.atr \
	mypdosr.atr mypdosrn.atr \
	mypdosb.atr \
	myinit.atr

#all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr

#ASMFLAGS= -Ihisio
ASMFLAGS = -Ihisio -s
#ASMFLAGS = -Ihisio -s -dHWDEBUG

MYPDOSINC = common.inc getdens.src longname.src \
	rreadcode.src comloadcode.src basloadcode.src \
	rread.bin comload.bin basload.bin

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src

rread.bin: rread.src rreadcode.src common.inc
	$(ATASM) $(ASMFLAGS) -r rread.src

basload.bin: basload.src basloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r basload.src

comload.bin: comload.src comloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r comload.src

highspeed.bin: highspeed.src highspeedcode.src $(HISIOINC) \
	common.inc rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -r highspeed.src

mypdos.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdos.bin -dHIGHSPEED=1 mypdos.src

mypdosr.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdosr.bin -dHIGHSPEED=1 -dREMOTE=1 mypdos.src

mypdosb.bin: mypdos.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -r -omypdosb.bin -dBAREBONE=1 mypdos.src

mypdos.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdos.atr -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 mypdos.src

mypdosn.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdosn.atr -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dHIDEF=0 mypdos.src

mypdosr.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdosr.atr -dREMOTE=1 -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 mypdos.src

mypdosrn.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdosrn.atr -dREMOTE=1 -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dHIDEF=0 mypdos.src

mypdosb.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdosb.atr -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dBAREBONE=1 mypdos.src

mypdos-code.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdos-code.bin -dMYPDOSROM=1 -dHIGHSPEED=1 mypdos.src

mypdos-code-hioff.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -r -omypdos-code-hioff.bin -dMYPDOSROM=1 -dHIGHSPEED=1 -dHIDEF=0 mypdos.src

mypdos-code-r.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdos-code-r.bin -dMYPDOSROM=1 -dHIGHSPEED=1 -dREMOTE=1 mypdos.src

mypdos-code-r-hioff.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdos-code-r-hioff.bin -dMYPDOSROM=1 -dHIGHSPEED=1 -dREMOTE=1 -dHIDEF=0 mypdos.src

mypdos-code-b.bin: mypdos.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -r -omypdos-code-b.bin -dMYPDOSROM=1 -dBAREBONE=1 mypdos.src

mypdos-atarisio.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -r -omypdos-atarisio.bin -dMYPDOSBIN=1 -dHIGHSPEED=1 -dREMOTE=1 mypdos.src

MYINIT.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdos.bin
	$(ATASM) $(ASMFLAGS) -oMYINIT.COM myinit.src

MYINITR.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdosr.bin
	$(ATASM) $(ASMFLAGS) -oMYINITR.COM -dREMOTE=1 myinit.src

MYINITB.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdosb.bin
	$(ATASM) $(ASMFLAGS) -oMYINITB.COM -dBAREBONE=1 myinit.src

MYPDOS.COM: mypdos-code.bin mypdos-com.src
	$(ATASM) $(ASMFLAGS) -oMYPDOS.COM -dHIDEF=1 mypdos-com.src

MYPDOSN.COM: mypdos-code-hioff.bin mypdos-com.src
	$(ATASM) $(ASMFLAGS) -oMYPDOSN.COM -dHIDEF=0 mypdos-com.src

MYPDOSR.COM: mypdos-code-r.bin mypdos-com.src
	$(ATASM) $(ASMFLAGS) -oMYPDOSR.COM -dHIDEF=1 -dREMOTE=1 mypdos-com.src

MYPDOSRN.COM: mypdos-code-r-hioff.bin mypdos-com.src
	$(ATASM) $(ASMFLAGS) -oMYPDOSRN.COM -dHIDEF=0 -dREMOTE=1 mypdos-com.src

MYPDOSB.COM: mypdos-code-b.bin mypdos-com.src
	$(ATASM) $(ASMFLAGS) -oMYPDOSB.COM -dBAREBONE=1 mypdos-com.src

MYPDIDE.ROM: mypdos-code-hioff.bin mypdrom.src
	$(ATASM) $(ASMFLAGS) -r -oMYPDIDE.ROM mypdrom.src

picostd405.c: mypdos.bin
	dd if=mypdos.bin bs=1 skip=384 | xxd -i > picostd405.c

picorem405.c: mypdosr.bin
	dd if=mypdosr.bin bs=1 skip=384 | xxd -i > picorem405.c

picobare405.c: mypdosb.bin
	dd if=mypdosb.bin bs=1 skip=384 | xxd -i > picobare405.c

bootstd405.c: mypdos.bin
	dd if=mypdos.bin bs=1 count=384 | xxd -i > bootstd405.c

bootrem405.c: mypdosr.bin
	dd if=mypdosr.bin bs=1 count=384 | xxd -i > bootrem405.c

bootbare405.c: mypdosb.bin
	dd if=mypdosb.bin bs=1 count=384 | xxd -i > bootbare405.c

# picoboot mini COM loader

picobootcode.bin: picobootcode.src common.inc rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -v -r -opicobootcode.bin picobootcode.src

PICOBOOT.COM: picobootinit.src picobootcode.bin getdens.src
	$(ATASM) $(ASMFLAGS) -oPICOBOOT.COM picobootinit.src


picoboot405.c: picobootcode.bin
	dd if=picobootcode.bin bs=1 count=384 | xxd -i > picoboot405.c

atarisio: mypdos-atarisio.bin bootstd405.c bootrem405.c bootbare405.c \
	picostd405.c picorem405.c picobare405.c picoboot405.c

myinit.atr: MYINIT.COM MYINITR.COM MYINITB.COM \
	MYPDOS.COM MYPDOSN.COM \
	MYPDOSR.COM MYPDOSRN.COM \
	MYPDOSB.COM PICOBOOT.COM \
	initdisk
	cp -f MYINIT.COM MYINITR.COM MYINITB.COM \
	MYPDOS.COM MYPDOSN.COM \
	MYPDOSR.COM MYPDOSRN.COM \
	MYPDOSB.COM PICOBOOT.COM \
	initdisk
	dir2atr -b MyDos453 720 myinit.atr initdisk


myinit3:
	mkdir myinit3

myinit3.atr: MYPDOS.COM myinit3
	cp MYPDOS.COM myinit3/MYDOS.AR0
	unix2atr -m 720 myinit3.atr myinit3

disk:
	mkdir disk

mytest.atr:	MYPDOS.COM mypdos.atr mypdoshs.atr disk
	if test ! -d disk ; then mkdir disk ; fi
	cp MYPDOS.COM disk
	dd if=mypdos.atr of=disk/MYPDOS.BIN bs=1 skip=16
	dd if=mypdoshs.atr of=disk/MYPDOSHS.BIN bs=1 skip=16
	unix2atr 720 mytest.atr disk/

clean:
	rm -f *.65o *.bin *.COM *.atr *.ROM *.SYS \
	bootstd*.c bootrem*.c bootbare*.c \
	picostd*.c picorem*.c picobare*.c

backup:
	tar zcf bak/mypdos-`date '+%y%m%d-%H%M'`.tgz *.src *.inc \
	Makefile README* LICENSE autoexec.bat mkdist

