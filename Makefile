# 
# MyPicoDos V4.05 Makefile (c) 2003-2010 by Matthias Reichl <hias@horus.com>
#

ATASM=atasm
#ATASM=/data/src/xl/atasm103/src/atasm

all: 512k.rom


#all: MYINIT.COM MYINITR.COM \
#	MYPDOS.COM MYPDOSN.COM \
#	MYPDOSR.COM MYPDOSRN.COM \
#	MYPDOSB.COM PICOBOOT.COM \
#	MYPDOSS.COM \
#	mypdos.atr mypdosn.atr \
#	mypdosr.atr mypdosrn.atr \
#	mypdoss0.atr mypdoss1.atr \
#	mypdosb.atr \
#	myinit.atr

#all: MYPDOS.COM mypdos.atr mypdoshs.atr myinit2.atr

#ASMFLAGS= -Ihisio -Icartsio
ASMFLAGS = -Ihisio -Icartsio -s
#ASMFLAGS = -Ihisio -Icartsio -v -s
#ASMFLAGS = -Ihisio -Icartsio -s -dHWDEBUG

MYPDOSINC = common.inc getdens.src longname.src \
	rreadcode.src comloadcode.src basloadcode.src \
	rread.bin comload.bin basload.bin

HISIOINC = hisio/hisio.inc hisio/hisiocode.src hisio/hisiodet.src \
	hisio/hisiocode-break.src hisio/hisiocode-cleanup.src \
	hisio/hisiocode-main.src hisio/hisiocode-send.src \
	hisio/hisiocode-check.src hisio/hisiocode-diag.src \
	hisio/hisiocode-receive.src hisio/hisiocode-vbi.src

CARTSIOINC = cartsio/cartsiocode.src cartsio/cartsio.inc

rread.bin: rread.src rreadcode.src common.inc
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

basload.bin: basload.src basloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

comload.bin: comload.src comloadcode.src common.inc rreadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

highspeed.bin: highspeed.src highspeedcode.src $(HISIOINC) \
	common.inc rreadcode.src comloadcode.src
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

cartsio.bin: cartsiobin.src $(CARTSIOINC)
	$(ATASM) $(ASMFLAGS) -r -o$@ $<

mypdos-code.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -r -o$@ $<

mypdos-code-hioff.bin: mypdos.src $(MYPDOSINC) \
	highspeedcode.src $(HISIOINC) highspeed.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dHIGHSPEED=1 -dHIDEF=0 -r -o$@ $<

mypdos-code-cartsio.bin: mypdos.src $(MYPDOSINC) \
	cartsio.src $(CARTSIOINC) cartsio.bin
	$(ATASM) $(ASMFLAGS) -dMYPDOSROM=1 -dCARTSIO=1 -r -o$@ $<

mypdos16.rom: mypdrom.src mypdos-code-cartsio.bin cartsio.bin
	$(ATASM) $(ASMFLAGS) -r -f255 -o$@ $<

8kblank.rom:
	dd if=/dev/zero bs=8k count=1 | tr '\000' '\377' > 8kblank.rom

16kblank.rom:
	dd if=/dev/zero bs=16k count=1 | tr '\000' '\377' > 16kblank.rom

512kbase.rom: mypdos16.rom 16kblank.rom
	cat mypdos16.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	16kblank.rom 16kblank.rom 16kblank.rom 16kblank.rom \
	> $@

512k.rom: 512kbase.rom testdisk.raw testdd.atr
	cp -f 512kbase.rom $@
	dd if=testdisk.raw of=$@ conv=notrunc bs=16384 seek=1
	dd if=testdd.atr of=$@ conv=notrunc bs=1 seek=164608 skip=400

testdisk.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P 1040 testdisk.atr testdisk

testdd.atr: testdisk testdisk/*
	dir2atr -b MyPicoDos405N -P -d 720 testdd.atr testdisk

testdisk.raw: testdisk.atr
	dd if=$< of=$@ bs=16 skip=1

disk:
	mkdir disk

clean:
	rm -f *.65o *.bin *.COM *.atr *.rom
