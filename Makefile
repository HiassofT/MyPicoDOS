# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM ?= atasm

all: MYINIT.COM MYINITR.COM \
	MYPDOS.COM MYPDOSN.COM \
	MYPDOSR.COM MYPDOSRN.COM \
	MYPDOSB.COM PICOBOOT.COM \
	MYPDOSS.COM \
	mypdos.atr mypdosn.atr \
	mypdosr.atr mypdosrn.atr \
	mypdoss0.atr mypdoss1.atr \
	mypdosb.atr \
	myinit.atr

#all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr

ASMFLAGS= -Ihisio
#ASMFLAGS= -Ihisio -v
#ASMFLAGS = -Ihisio -s
#ASMFLAGS = -Ihisio -v -s
#ASMFLAGS = -Ihisio -s -dHWDEBUG

MYPDOSINC = common.inc getdens.src longname.src \
	rreadcode.src comloadcode.src basloadcode.src \
	rread.bin comload.bin basload.bin

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

rread.bin: rread.src rreadcode.src common.inc
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

basload.bin: basload.src basloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

comload.bin: comload.src comloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

highspeed.bin: highspeed.src highspeedcode.src $(HISIOINC) \
	common.inc rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED=1 -r -o$@ $<

mypdosr.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED=1 -dREMOTE=1 -r -o$@ $<

mypdoss.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dHIGHSPEED=1 -dSDRIVE=1 -r -o$@ $<

mypdosb.bin: mypdos.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -dBAREBONE=1 -r -o$@ $<

mypdos.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -r -o$@ $<

mypdosn.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dHIDEF=0 -r -o$@ $<

mypdoss0.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dSDRIVE=1 -dSDDEF=0 -r -o$@ $<

mypdoss1.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dSDRIVE=1 -dSDDEF=1 -r -o$@ $<

mypdosr.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dREMOTE=1 -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -r -o$@ $<

mypdosrn.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dREMOTE=1 -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dHIGHSPEED=1 -dHIDEF=0 -r -o$@ $<

mypdosb.atr: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSATR=1 -dMYPDOSBIN=1 -dDEFDRIVE=2 -dBAREBONE=1 -r -o$@ $<

mypdos-code.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -r -o$@ $<

mypdos-code-hioff.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -dHIDEF=0 -r -o$@ $<

mypdos-code-r.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -dREMOTE=1 -r -o$@ $<

mypdos-code-s.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -dSDRIVE=1 -r -o$@ $<

mypdos-code-r-hioff.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -dREMOTE=1 -dHIDEF=0 -r -o$@ $<

mypdos-code-b.bin: mypdos.src $(MYPDOSINC)
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dBAREBONE=1 -r -o$@ $<

atarisio-mypdos.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin \
	remote.src
	$(ATASM) $(ASMFLAGS) -dMYPDOSBIN=1 -dHIGHSPEED=1 -dREMOTE=1 -r -o$@ $<

MYINIT.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdos.bin
	$(ATASM) $(ASMFLAGS) -o$@ $<

MYINITR.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdosr.bin
	$(ATASM) $(ASMFLAGS) -dREMOTE=1 -o$@ $<

MYINITS.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdoss.bin
	$(ATASM) $(ASMFLAGS) -dSDRIVE=1 -o$@ $<

MYINITB.COM: myinit.src getdens.src longname.src qsort.src cio.inc \
	mypdosb.bin
	$(ATASM) $(ASMFLAGS) -dBAREBONE=1 -o$@ $<

MYPDOS.COM: mypdos-com.src mypdos-code.bin
	$(ATASM) $(ASMFLAGS) -dHIDEF=1 -o$@ $<

MYPDOSN.COM: mypdos-com.src mypdos-code-hioff.bin
	$(ATASM) $(ASMFLAGS) -dHIDEF=0 -o$@ $<

MYPDOSR.COM: mypdos-com.src mypdos-code-r.bin
	$(ATASM) $(ASMFLAGS) -dHIDEF=1 -dREMOTE=1 -o$@ $<

MYPDOSS.COM: mypdos-com.src mypdos-code-s.bin
	$(ATASM) $(ASMFLAGS) -dHIDEF=1 -dREMOTE=1 -o$@ $<

MYPDOSRN.COM: mypdos-com.src mypdos-code-r-hioff.bin
	$(ATASM) $(ASMFLAGS) -dHIDEF=0 -dREMOTE=1 -o$@ $<

MYPDOSB.COM: mypdos-com.src mypdos-code-b.bin
	$(ATASM) $(ASMFLAGS) -dBAREBONE=1 -o$@ $<

MYPDIDE.ROM: mypdrom.src mypdos-code-hioff.bin
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

picostd405.c: mypdos.bin
	dd if=$< bs=1 skip=384 | xxd -i > $@

picosd405.c: mypdoss.bin
	dd if=$< bs=1 skip=384 | xxd -i > $@

picorem405.c: mypdosr.bin
	dd if=$< bs=1 skip=384 | xxd -i > $@

picobare405.c: mypdosb.bin
	dd if=$< bs=1 skip=384 | xxd -i > $@

bootstd405.c: mypdos.bin
	dd if=$< bs=1 count=384 | xxd -i > $@

bootsd405.c: mypdoss.bin
	dd if=$< bs=1 count=384 | xxd -i > $@

bootrem405.c: mypdosr.bin
	dd if=$< bs=1 count=384 | xxd -i > $@

bootbare405.c: mypdosb.bin
	dd if=$< bs=1 count=384 | xxd -i > $@

# picoboot mini COM loader

picobootcode.bin: picobootcode.src common.inc rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

PICOBOOT.COM: picobootinit.src picobootcode.bin getdens.src
	$(ATASM) $(ASMFLAGS) -o$@ $<


picoboot405.c: picobootcode.bin
	dd if=$< bs=1 count=384 | xxd -i > $@

atarisio: atarisio-mypdos.bin \
	bootstd405.c picostd405.c \
	bootrem405.c picorem405.c \
	bootbare405.c picobare405.c \
	bootsd405.c picosd405.c \
	picoboot405.c

MYINIT_COMS=MYINIT.COM MYINITR.COM MYINITB.COM \
	MYPDOS.COM MYPDOSN.COM \
	MYPDOSR.COM MYPDOSRN.COM \
	MYPDOSB.COM PICOBOOT.COM \
	MYINITS.COM

initdisk/AUTOEXEC.BAT: autoexec.bat
	tr '\012' '\233' < $< > $@

myinit.atr: $(MYINIT_COMS) initdisk initdisk/AUTOEXEC.BAT
	cp -f $(MYINIT_COMS) initdisk
	dir2atr -b MyDos4534 720 myinit.atr initdisk


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
	bootstd*.c bootrem*.c bootbare*.c bootsd*.c \
	picostd*.c picorem*.c picobare*.c picosd*.c \
	picoboot*.c

backup:
	tar zcf bak/mypdos-`date '+%y%m%d-%H%M'`.tgz *.src *.inc \
	Makefile README* LICENSE autoexec.bat mkdist

